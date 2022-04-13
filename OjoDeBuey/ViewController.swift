//
//  ViewController.swift
//  OjoDeBuey
//
//  Created by Ricardo Roman Landeros on 14/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    //valor actual del slider que guardamos aqui para que sea global
    var currentValue: Int = 0
    //valor que almacenrara el numero aletario
    var targetValue: Int = 0
    var score: Int = 0
    var round: Int = 0
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)

        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)

        let insets = UIEdgeInsets(
          top: 0,
          left: 14,
          bottom: 0,
          right: 14)

        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(
          withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)

        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(
          withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        //hacemos que el valor de current value sea el mismo que slider al iniciar la app
       // currentValue = lroundf(slider.value)
        //generar el numero aletorio
        //targetValue = Int.random(in: 1...100)
        //startNewRound()
        starNewGame()
    }

    @IBAction func showAlert() {
        
        //primera forma de solucionm
//        var difference: Int
//
//        if currentValue > targetValue {
//            difference = currentValue - targetValue
//        } else if targetValue > currentValue {
//            difference = targetValue - currentValue
//        } else {
//            difference = 0
//        }
        //segunda forma de solucion
//        var difference = currentValue - targetValue
//        if difference < 0 {
//            difference *= -1
//        }
        
        //tercera forma de solucion
        //aqui usamos la funcion denumero absoluto
        let difference = abs(targetValue - currentValue)
        //con esta constante sabemos cunatos putnos gano
        var points = 100 - difference
        
        
        let title: String
        if difference == 0 {
            title = "Perfecto"
            points += 100
        } else if difference < 5 {
            title = "Casi lo tenias"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Buen trabajo"
        } else {
            title = "Puro Sueño"
        }
    
        score += points
        
//        let message = "El valor de el slider es \(currentValue)" +
//                      "\nEl numero a encontar es el \(targetValue)" +
//                      "\nLa Diferencia es \(difference)" +
//                      "\nSus puntos en esta ronda son \(points)"
        
        let message = "Tu puntuacion es de \(points)" +
                      "\nel valor que tu ingresaste fue \(currentValue)"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: {_ in
                self.startNewRound()
            })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slier: UISlider){
        print("el valor del slider es ahora \(slier.value)")
        //asiganos el valor que el usuario le da al slider y lo redondeamos a entero
        currentValue = lroundf(slier.value)
    }
    
    @IBAction func starNewGame(){
        score = 0
        round = 0
        startNewRound()
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
    }
    
    //metodo para iniciar nueva ronda
    func startNewRound() {
        round += 1
        //sacamos un nuevo numero random
        targetValue = Int.random(in: 1...100)
        //el slider lo ponemos a la mitad
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    //meto para actulizar todos los label
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

}

