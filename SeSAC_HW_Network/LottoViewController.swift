//
//  LottoViewController.swift
//  SeSAC_HW_Network
//
//  Created by 박지은 on 1/16/24.
//

import UIKit
import Alamofire

struct Lotto: Decodable {
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}

class LottoViewController: UIViewController {

    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var lottoNumberLabel: UILabel!
    
    let numberList: [Int] = Array(1...1102).reversed()
    
    var lottoPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberTextField.tintColor = .clear
        numberTextField.inputView = lottoPickerView
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
        callRequest()

    }
    
    func callRequest() {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1102"
        AF
            .request(url)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let success):
                    self.lottoNumberLabel.text = "\(String(success.drwtNo1)) \(String(success.drwtNo2)) \(String(success.drwtNo3)) \(String(success.drwtNo4)) \(String(success.drwtNo5)) \(String(success.drwtNo6))"
                case .failure(let failure):
                    print("오류 발생")
                }
            }
    }
    
}



extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberTextField.text = "\(numberList[row])회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
    
}
