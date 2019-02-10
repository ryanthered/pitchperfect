import AVFoundation
import UIKit

class RecordAudioViewController: UIViewController {
    
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func recordAudio(_ sender: Any) {
        recordingLabel.text = "Recording in Progress..."
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
        // Set up local directory and .wav container
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        // Initialize AVAudioSession
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        // Initialize AVAudioRecorder and start recording
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        print("Recording to file: \(filePath!)")
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        recordingLabel.text = "Tap to Record!"
        recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        
        // Shut down recorder and session
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
}

