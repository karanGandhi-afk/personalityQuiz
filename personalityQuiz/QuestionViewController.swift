//
//  QuestionViewController.swift
//  personalityQuiz
//
//  Created by Karan Gandhi on 3/22/21.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    
    @IBOutlet weak var singleStackView: UIStackView!
    
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    
    
    
    
    
    
    

    @IBOutlet weak var multipleStackView: UIStackView!
    
    @IBOutlet weak var multipleLabel1: UILabel!
    @IBOutlet weak var multipleLabel2: UILabel!
    @IBOutlet weak var multipleLabel3: UILabel!
    @IBOutlet weak var multipleLabel4: UILabel!
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    
    
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    
    //Type Annotation
    var questions : [Question] = [
    
        
        Question(text: "Which food do you like the most?", type: .single,
                 
                 
                 answer: [
                    
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrots", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)
                    
                    
                    ]),
        
        
        
        
        Question(text: "Which activities do you enjoy?", type: .multiple,
                 
                 
                 answer: [
                    
                    Answer(text: "Swimming", type: .turtle),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Cuddling", type: .rabbit),
                    Answer(text: "Eating", type: .dog)
                    
                    
                    ]),
        
        
        
        Question(text: "How much do you enjoy car rides?", type: .ranged,
                 
                 
                 answer: [
                    
                    Answer(text: "I dislike them", type: .cat),
                    Answer(text: "I get a little nervous", type: .rabbit),
                    Answer(text: "I barely notice them", type: .turtle),
                    Answer(text: "I love them", type: .dog)
                    
                    
                    ])
        
        
        
        
        
    
    
    
    
    ]
    
    
    
    
    
    var questionIndex = 0
    var answersChosen : [Answer] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        updateUI()

        // Do any additional setup after loading the view.
    }
    
   
    
    
    
    //1) Answer should get recorded -> Storing in the answersChosen array
    //2) Go to the next question
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        
        
        let currentAnswers = questions[questionIndex].answer
        
        
        
        switch sender{
        
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        
            
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        
            
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        
            
        default:
            break
        }
        
        nextQuestion()
        
        
    }
    
    
    //1. Link our switch
    //2. Create function from submit answer
    
    
    
    @IBAction func multipleAnswerButtonPressed(_ sender: UIButton) {
        
        let currentAnswers = questions[questionIndex].answer
        
        if multiSwitch1.isOn {
            
            answersChosen.append(currentAnswers[0])
       
            
        if multiSwitch2.isOn {
                
            answersChosen.append(currentAnswers[1])
            
                
            }
        if multiSwitch3.isOn {
                
            answersChosen.append(currentAnswers[2])
            
                
            }
                
        if multiSwitch4.isOn {
                
            answersChosen.append(currentAnswers[3])
            
                
            }
            
        nextQuestion()
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
     
    @IBAction func rangedAnswerButtonPressed() {
    
    
        let currentAnswers = questions[questionIndex].answer
        
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
      
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
        
        
        
    }
    
    
    
    
    
    
    
    
    
    func nextQuestion()
    {
        
        questionIndex += 1
        
        if questionIndex < questions.count {
            
            updateUI()
            
        }
        
        else {
            
            
            performSegue(withIdentifier: "ResultsSegue", sender: self)
            
            
            
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            
            let resultsViewController = segue.destination as! ResultViewController
            
            resultsViewController.responses = answersChosen
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    func updateUI()
    
    {
        
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        
        
        navigationItem.title = "Question Number : \(questionIndex+1)"
        
        
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answer
        
        
        let totalProgress = Float(questionIndex)/Float(questions.count)
        
        questionProgressView.setProgress(totalProgress, animated: true)
        questionLabel.text = currentQuestion.text
        
        
        
        switch currentQuestion.type {
        
        
        case .single:
            
            updateSingleStack(using : currentAnswers)
            
            
            
        case .multiple:
           
            updateMultipleStack(using : currentAnswers)
            
            
            
        case .ranged:
           
            updateRangedStack(using : currentAnswers)
        }
        
        
        
    }

    
    
    func updateSingleStack(using answers : [Answer] ){
        
        singleStackView.isHidden = false
        
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
        
    }
    
    
    func updateMultipleStack(using answers : [Answer] ){
        
       

        multipleStackView.isHidden = false
//        multiSwitch1.isOn = false
//        multiSwitch2.isOn = false
//        multiSwitch3.isOn = false
//        multiSwitch4.isOn = false
//        
        multipleLabel1.text = answers[0].text
        multipleLabel2.text = answers[1].text
        multipleLabel3.text = answers[2].text
        multipleLabel4.text = answers[3].text
        
        
    }
    
    
    func updateRangedStack(using answers : [Answer] ){
        
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
        
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    

}
