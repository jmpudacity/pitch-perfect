//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by JOSE MARIA PARRA on 25/04/15.
//  Copyright (c) 2015 jmp. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController:UIViewController, AVAudioRecorderDelegate {

  

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var tapToRecord: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
        tapToRecord.hidden = false
    }

    @IBAction func recordAudio(sender: UIButton) {
        
        //show code
        recordButton.enabled = false
        stopButton.hidden = false
        recordingInProgress.hidden = false;
        tapToRecord.hidden = true
        
        
        //record code
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        println(filePath)
        
        //set up audio session
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        //Init the recorder
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if(flag){
            
            //1. save the recorded audio

            recordedAudio = RecordedAudio ()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent

            //2. perform segue

            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        
        }else{
        
            println("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
            
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        
        recordingInProgress.hidden = true;
        
        //stop recording audio
        audioRecorder.stop()
        
        //free audio instance
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
            
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            
            let data = sender as RecordedAudio
            playSoundsVC.receivedAudio = data
            
        }
    }
    
}

