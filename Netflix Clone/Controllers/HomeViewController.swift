//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Beatriz Leonel da Silva on 30/08/22.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case UpcommingMovies = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    let sectionsTitles : [String] = ["Trending Movies", "Trending Tv", "Popular", "Upcomming Movies", "Top rated"]
    
    let homeFeedTable : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    lazy var headerView : HeroHeaderUIView = {
        let heroHeaderView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height/2))
        return heroHeaderView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        
        view.addSubview(homeFeedTable)
        homeFeedTable.tableHeaderView = headerView      //define o header da tableView
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func configureNavBar(){
        //cria um botaão customizado
        let normalButton = UIButton(type: .custom)
        normalButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        normalButton.setImage(UIImage(named: "nLogo"), for: .normal)
        
        //cria um botão da navifation bar com o botão customizado e seta a largura desse botão
        let leftButton = UIBarButtonItem(customView: normalButton)
        let width = leftButton.customView?.widthAnchor.constraint(equalToConstant: 20)
        width?.isActive = true
        
        //Coloca o botão final no leftBarButtonItem
        navigationItem.leftBarButtonItem = leftButton
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }

}

//Protocolo responsável por determinar a parte mais estrutural e visual da tabela
extension HomeViewController : UITableViewDelegate{
    
    //Define altura de cada linha
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //Define a altura das headers de cada section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //usuário scroll screen
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
}

//Protocolo responsável por determinar as células e seus dados
extension HomeViewController : UITableViewDataSource {
    
    //Define o número de sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsTitles.count
    }
    
    //Determina número de linhas em cada seção
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //Determina o conteúdo de cada célula
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        // verifica em qual secção está de acordo com o enum
        // faz a chamada de api para essa secçao
        // configura a célula com o que foi obtido da chamada
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies(completion: { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTvs(completion: { result in
                switch result {
                case .success(let tvs):
                    cell.configure(with: tvs)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            
        case Sections.Popular.rawValue:
            APICaller.shared.getPopularMovies(completion: { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            
        case Sections.UpcommingMovies.rawValue:
            APICaller.shared.getUpcommingMovies(completion: { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            })
            
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRatedMovies(completion: { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    //define o título na header de cada section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsTitles[section]
    }
    
    //configuraçõe para fazer antes da header da section ser mostrada
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold) //qual outra forma de fazer?
        header.textLabel?.textColor = .white //Qual outra forma de fazer?
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height) //Qual outra forma de fazer??
    }
    
}
