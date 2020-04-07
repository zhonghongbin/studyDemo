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
    private lazy var audioQueue = DispatchQueue.global()
    private lazy var session : AVCaptureSession = AVCaptureSession()
    private lazy var preview :AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    private var connection : AVCaptureConnection?
    private var videoInput :AVCaptureDeviceInput?
    private var movieOutput :AVCaptureMovieFileOutput?
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
        setVideo()
        
        setAudio()
        
        //添加写入文件的output
        let movieOutput = AVCaptureMovieFileOutput()
        session.addOutput(movieOutput)
        self.movieOutput = movieOutput
        //设置写入稳定性
        let connection = movieOutput.connection(with: .video)
        connection?.preferredVideoStabilizationMode = .auto
        
        //用户看到预览涂层
        preview.frame = view.bounds
        view.layer.addSublayer(preview)
        //开始采集
        session.startRunning()
        
        //开始将采集画面写入文件中
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/test.mp4"
        let url = URL(fileURLWithPath: path)
        movieOutput.startRecording(to: url, recordingDelegate: self)
        
    }
    @IBAction func finish() {
        print("结束")
        movieOutput?.stopRecording()
        session.stopRunning()
        preview.removeFromSuperlayer()
    }
    @IBAction func changeSence() {
        guard var positon = videoInput?.device.position else { return }
        
        positon = positon == .front ? .back : .front
        
        let devices = AVCaptureDevice.devices(for: .video) as? [AVCaptureDevice]
        guard let device = devices?.filter({$0.position == positon}).first else {return}
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else {return}
        //切换input
        session.beginConfiguration()
        session.removeInput(self.videoInput!)
        session.addInput(videoInput)
        session.commitConfiguration()
        self.videoInput = videoInput
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
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
extension RoomViewController:AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate{
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if connection == self.connection{
            print("开始视频采集")
        }else{
            print("开始音频采集")
        }
        
    }
}
extension RoomViewController{
    func setVideo(){
        guard let devices = AVCaptureDevice.devices(for: AVMediaType.video) as? [AVCaptureDevice] else{
            print("摄像头不可用")
            return }
        guard let device = devices.filter({ $0.position == .front}).first else {return}
        //通过device创建input对象
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else {return}
        
        self.videoInput = videoInput
        
        session.addInput(videoInput)
        //创建输出源
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        session.addOutput(videoOutput)
        //获取video的connection
        connection = videoOutput.connection(with: .video)
    }
    func setAudio(){
        guard let device = AVCaptureDevice.default(for: .audio) else {return}
        guard let audioInput = try? AVCaptureDeviceInput(device: device) else { return }
        
        session.addInput(audioInput)
        
        let audioOutput = AVCaptureAudioDataOutput()
        audioOutput.setSampleBufferDelegate(self, queue: audioQueue)
    }
}
extension RoomViewController :AVCaptureFileOutputRecordingDelegate{
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("开始写入")
    }
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("停止写入")
    }
    
    
}
