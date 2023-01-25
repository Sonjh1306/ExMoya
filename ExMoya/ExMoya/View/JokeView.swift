import UIKit
import Kingfisher

final class JokeView: UIView {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        return imageView
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let updateAtLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let urlLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let changeButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.setTitle("CHANGE", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = UIColor.red
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.color = .black
        activityIndicator.stopAnimating()
        return activityIndicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addSubViews() {
        self.addSubview(iconImageView)
        self.addSubview(idLabel)
        self.addSubview(updateAtLabel)
        self.addSubview(urlLabel)
        self.addSubview(valueLabel)
        self.addSubview(changeButton)
        self.addSubview(activityIndicator)
        self.bringSubviewToFront(activityIndicator)
    }
    
    private func configureConstraints() {
        addSubViews()
        
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(50)
        }
        
        idLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        
        updateAtLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        
        urlLabel.snp.makeConstraints {
            $0.top.equalTo(updateAtLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints {
            $0.top.equalTo(urlLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
        
        changeButton.snp.makeConstraints {
            $0.top.equalTo(valueLabel.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    
    func configureJokeData(joke: Joke) {
        let imageUrl = URL(string: joke.iconURL)
        self.iconImageView.kf.setImage(with: imageUrl)
        
        self.idLabel.text = joke.id
        self.updateAtLabel.text = joke.updatedAt
        self.urlLabel.text = joke.url
        self.valueLabel.text = joke.value
    }
}
