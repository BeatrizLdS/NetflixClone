//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Beatriz Leonel da Silva on 05/09/22.
//

import UIKit

// Estrutura genérica para um array
struct Array<Element> {
    var elements: [Element] = []
}


class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"
    private var titles: Array = Array<Any>()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //define o frame de cada céula da collectionView
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    // função que configura a lista de títulos(conteúdo das células) que aquela collection vai ter
    public func configure<Element>(with titles: [Element]) {
        self.titles.elements = titles
        // para poder carregar o conteúdo da collection quando obtenho os dados para ela
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

//Define Ações e comportamentos
extension CollectionViewTableViewCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Section: ", indexPath.section)
        print("Row: ", indexPath.row)
    }
}

//Define os dados da collectionView
extension CollectionViewTableViewCell : UICollectionViewDataSource {
    
    // seta quem é a célula da colléction view
    //configura a célula com a url da imagem obtida
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let object = titles.elements[indexPath.row]
        if object is Movie {
            let objectMovie = object as? Movie
            guard let poster = objectMovie?.poster else {
                return UICollectionViewCell()
            }
            cell.configure(with: poster)
        }
        else {
            let objectTv = object as? Tv
            guard let poster = objectTv?.poster else {
                return UICollectionViewCell()
            }
            cell.configure(with: poster)
        }
        return cell
    }
    
    //seta quantas células vão ter cada section da collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.elements.count
    }
    
}
