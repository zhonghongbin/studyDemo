//
//  RoomViewController.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/30.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
import AVFoundation
class RoomViewController: UIViewController ,UIGestureRecognizerDelegate{
    private lazy var videoQueue = DispatchQueue.global()
    private lazy var session : AVCaptureSession = AVCaptureSession()
    private lazy var preview :AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    //动态加载button
//    private lazy var button:UIButton = {
//        let button = UIButton.init(type: .custom)
//        button.frame = CGRect(x: 40, y: 40, width: 40, height: 40)
//        button.backgroundColor = UIColor.blue
//        button.setTitle("start", for: .normal)
//        button.addTarget(self, action: #selector(start), for: .touchUpInside)
////        button.stopVide.addTarget(self, action: #selector(stop), for: .touchUpInside)
//        return button
//    }()
    @IBAction func begin() {
        print("开始")
        guard let devices = AVCaptureDevice.devices(for: AVMediaType.video) as? [AVCaptureDevice] else{ return }
        guard let device = devices.filter({ $0.position == .front}).first else {return}
        //通过device创建input对象
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else {return}
        session.addInput(videoInput)
        //创建输出源
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        session.addOutput(videoOutput)
        //用户看到预览涂层
        preview.frame = view.bounds
        view.layer.addSublayer(preview)
        //开始采集
        session.startRunning()
        
    }
    @IBAction func finish() {
        print("结束")
        session.stopRunning()
        preview.removeFromSuperlayer()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.orange
//        view.addSubview(button)
    }
    //当view即将出现时调用，用来隐藏navigationbar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //添加手势
        //系统手势，只支持最左侧
        //        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        //        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
extension RoomViewController:AVCaptureVideoDataOutputSampleBufferDelegate{
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print("开始视频采集")
    }
}
