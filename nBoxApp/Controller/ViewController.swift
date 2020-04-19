//
//  ViewController.swift
//  nBoxApp
//
//  Created by Erim Şengezer on 14.04.2020.
//  Copyright © 2020 Erim Şengezer. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds
import AVFoundation
import GoogleSignIn

class ViewController: UIViewController, GADInterstitialDelegate, AVSpeechSynthesizerDelegate {
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    var interstitial : GADInterstitial!
    var readButtonCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-9394312041468898/9609702768")
        interstitial.delegate = self
        loadAds()
        
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (timer) in
//            self.showAds()
        }
        
        speechSynthesizer.delegate = self
        
//        let encodedString = "The Weeknd <em>&#8216;King Of The Fall&#8217;</em>"
        let string = """
<p style="font-size:20px">2018 yılında Microsoft tarafından satın alınan dünyanın en popüler kod deposu GitHub'ın geçtiğimiz ay <a href="https://webrazzi.com/2020/03/18/github-in-ios-ve-android-icin-mobil-uygulamasi-yayina-alindi/">iOS ve Android platformları için uygulamalarını yayınladığını</a> sizlerle paylaşmıştık.</p><p>Bugün GitHub CEO'su Nat Friedman, yayınladığı bir <a href="https://github.blog/2020-04-14-github-is-now-free-for-teams/" target="_blank">blog yazısı</a>yla artık takımlar için de GitHub'ın ücretsiz olduğunu duyurdu.</p><p>Yazılım geliştiren takımlar daha öncesinde GitHub kullanmak istediğinde ücretli paketlerden birine abone olmak zorundaydı. </p>
"""
        
//        let decodedString = String(htmlEncodedString: encodedString)
//
//        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 30.0)! ]
//        let string = encodedString.htmlToAttributedString
        
        
        textView.attributedText = string.htmlToAttributedString
        
        
        
        
    }

    
    private func loadAds() {
        let request = GADRequest()
        interstitial.load(request)
    }
    
    private func showAds() {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }
    }

    @IBAction func readButtonClicked(_ sender: Any) {
        
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: "\(textView.text ?? "Okuyamıyorum")")
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "tr-TR")
        
        if readButtonCount == 0 || readButtonCount % 2 == 0 {
            readButton.setTitle("Pause", for: .normal)
            speechSynthesizer.speak(speechUtterance)
            speechSynthesizer.continueSpeaking()
        }
        else if readButtonCount % 2 == 1 {
            speechSynthesizer.pauseSpeaking(at: .immediate)
            readButton.setTitle("Read", for: .normal)
        }
        readButtonCount += 1
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "siriTest")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func signOutButtonClicked(_ sender: Any) {
        
        if Auth.auth().currentUser != nil {
            do {
                signOutSocialMedia()
                try Auth.auth().signOut()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "Auth")
                vc.modalPresentationStyle = .fullScreen
                
                self.present(vc, animated: true, completion: nil)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func signOutSocialMedia() {
        
        guard let user = Auth.auth().currentUser else { return }
        
        switch user.providerID {
        case GoogleAuthProviderID:
            GIDSignIn.sharedInstance().signOut()
            break
        default:
            return
        }
        
    }
    
}

/*
 Bu durum da yazılım geliştiren ekiplerin GitHub alternatiflerine yönelmesine sebep oluyordu.Friedman, blog yazısında ücretin yazılım geliştiren takımların GitHub kullanması için bariyer olmaması gerektiğini belirtmiş.</p><p>Bu gelişmeyle beraber yazılım geliştiren takımlar da artık ücretsiz bir şekilde CI/CD, proje yönetimi, kod inceleme gibi özellikleri ücretsiz kullanabilecek.</p><h3>Peki GitHub tamamen mi ücretsiz?</h3><p>Hayır, kurumsal özellikler, kişiselleştirilmiş müşteri desteği gibi daha gelişmiş özellikler kullanmak isteyen takımlar ücretli aboneliklerden faydalanabilecek. Daha önceleri kullanıcı başına aylık 9 dolar olan takım planı bu gelişmeyle beraber aylık 4 dolar seviyesine çekilmiş. Planlar da aşağıdaki gibi güncellenmiş.</p><p><img title="github-plans-266" class="lazyload " data-src="https://cdn.webrazzi.com/uploads/2020/04/github-plans-266.png" alt="" /></p><p>GitHub bundan bir yıl önce daha önceleri ücretli olan <a href="https://webrazzi.com/2019/01/08/github-ozel-depolari-sinirsiz-ve-ucretsiz-yapti/" target="_blank">sınırsız özel depo özelliğini ücretsiz hale getirmişti</a>. Anlaşılan GitHub, Microsoft desteğiyle beraber versiyon kontrol ve kod depolama alanında liderliğini sürdürebilmek ve büyümesini devam ettirebilmek için yazılım ekosistemini desteklemeye hızla devam edecek.
 */
