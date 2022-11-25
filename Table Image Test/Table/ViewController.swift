//
//  ViewController.swift
//  Table
//
//  Created by JinSeok Yang on 2022/10/14.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private var cityArrays = [City]()
    
    var cityDataManger = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setupData()

        setupNaviagtion()
        setTableView()
        
        layout()

    }
    

}

extension ViewController {
    
    func setupData() {
    
            cityDataManger.makeCityData()
            cityArrays = cityDataManger.getCityData()
        
   
        
    }
    
    func setTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func layout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

        
        ])
        
    }
    
    func setupNaviagtion() {
    
        let appearance = UINavigationBarAppearance()
        // 기본 설정 (standard, compact, scrollEdge)
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        appearance.configureWithDefaultBackground()              // 네이게이션바 불투명
        
        self.navigationItem.title = "Main"
        self.navigationController?.navigationBar.prefersLargeTitles = true  // 왼쪽 큰 타이틀 설정
        
//        appearance.backgroundColor = .red                          // 색상설정
//        self.navigationController?.navigationBar.tintColor = .red  // 틴트 설정
      
        // 탭바 오른쪽 버튼
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(tabBarButtonTapped))
    }
    
    @objc func tabBarButtonTapped() {
        cityArrays = cityDataManger.getCityData()
        cityDataManger.updateCityData()

        tableView.reloadData()
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArrays.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        
            cell.mainImage.image = cityArrays[indexPath.row].cityImage
            cell.mainLabel.text = cityArrays[indexPath.row].description
        
     
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController()
        detailVC.cityData = cityArrays[indexPath.row]
        
        detailVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailVC, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150

    }
  
    
    
}
