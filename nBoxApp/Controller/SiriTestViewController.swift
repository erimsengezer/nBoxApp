//
//  SiriTestViewController.swift
//  nBoxApp
//
//  Created by Erim Şengezer on 17.04.2020.
//  Copyright © 2020 Erim Şengezer. All rights reserved.
//

import UIKit
import AVFoundation

class SiriTestViewController: UIViewController {
    let speechSynthesizer = AVSpeechSynthesizer()

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let string = """

                        
                        Bu durum da yazılım geliştiren ekiplerin GitHub alternatiflerine yönelmesine sebep oluyordu.Friedman, blog yazısında ücretin yazılım geliştiren takımların GitHub kullanması için bariyer olmaması gerektiğini belirtmiş.</p><p>Bu gelişmeyle beraber yazılım geliştiren takımlar da artık ücretsiz bir şekilde CI/CD, proje yönetimi, kod inceleme gibi özellikleri ücretsiz kullanabilecek.</p><h3>Peki GitHub tamamen mi ücretsiz?</h3><p>Hayır, kurumsal özellikler, kişiselleştirilmiş müşteri desteği gibi daha gelişmiş özellikler kullanmak isteyen takımlar ücretli aboneliklerden faydalanabilecek. Daha önceleri kullanıcı başına aylık 9 dolar olan takım planı bu gelişmeyle beraber aylık 4 dolar seviyesine çekilmiş. Planlar da aşağıdaki gibi güncellenmiş.</p><p><img title="github-plans-266" class="lazyload " data-src="https://cdn.webrazzi.com/uploads/2020/04/github-plans-266.png" alt="" /></p><p>GitHub bundan bir yıl önce daha önceleri ücretli olan <a href="https://webrazzi.com/2019/01/08/github-ozel-depolari-sinirsiz-ve-ucretsiz-yapti/" target="_blank">sınırsız özel depo özelliğini ücretsiz hale getirmişti</a>. Anlaşılan GitHub, Microsoft desteğiyle beraber versiyon kontrol ve kod depolama alanında liderliğini sürdürebilmek ve büyümesini devam ettirebilmek için yazılım ekosistemini desteklemeye hızla devam edecek.
                        

                    """
        
        textView.attributedText = string.htmlToAttributedString
        read()
        
    }
    
    func read() {
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: "\(textView.text ?? "Okuyamıyorum")")
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "tr-TR")
        speechSynthesizer.speak(speechUtterance)
    }
    
    
    @IBAction func backButtonClicked(_ sender: Any) {
        speechSynthesizer.stopSpeaking(at: .immediate)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "News")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
