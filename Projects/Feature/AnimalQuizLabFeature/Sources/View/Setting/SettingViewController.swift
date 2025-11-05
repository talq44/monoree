import UIKit
import SnapKit
import Kingfisher
import FoundationShared

enum SettingViewSection: Int, CaseIterable {
    case imageStyle = 0
    case 소리설정
    case 자동넘김
    case version
    
    var title: String {
        switch self {
        case .imageStyle: return "이미지 스타일"
        case .자동넘김: return "자동 넘김"
        case .소리설정: return "소리 설정"
        case .version: return "버전 정보"
        }
    }
}

enum SettingViewImageStyle: Int, CaseIterable {
    case realistic
    case toy3D
    case anime2D
    case plush
    
    var name: String {
        switch self {
        case .realistic: return "실사형 스타일"
        case .toy3D: return "3D 장난감 스타일"
        case .anime2D: return "2D 동화책 스타일"
        case .plush: return "봉제인형 스타일"
        }
    }
    
    var type: String {
        String(describing: self)
    }
    
    var imageURL: URL? {
        URL(string: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/\(type)/lion.webp")
    }
}

enum SettingViewAutoScrollStyle: Int, CaseIterable {
    case second1
    case second3
    case second5
    case second10
    
    var second: Int {
        switch self {
        case .second1: return 1
        case .second3: return 3
        case .second5: return 5
        case .second10: return 10
        }
    }
    
    var systemImageName: String {
        switch self {
        case .second1: return "1.brakesignal"
        case .second3: return "3.circle"
        case .second5: return "5.arrow.trianglehead.clockwise"
        case .second10: return "10.arrow.trianglehead.clockwise"
        }
    }
}

final class SettingViewController: BaseViewController {
    typealias Cell = UITableViewCell
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var selectImageIndex: Int = 0
    private var selectedAutoScrollRow: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "설정"
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func switchTTSOn(_ isOn: Bool) {
        
    }
}

extension SettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
        guard let section = SettingViewSection(rawValue: sectionIndex) else { return 0 }
        switch section {
        case .imageStyle:
            return 4
        case .소리설정:
            return 1
        case .자동넘김:
            return 4
        case .version:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SettingViewSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch section {
        case .imageStyle:
            if indexPath.row == selectImageIndex {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
            guard let imageStyle = SettingViewImageStyle(rawValue: indexPath.row) else {
                cell.textLabel?.text = "알수 없음"
                return cell
            }
            
            cell.textLabel?.text = imageStyle.name
            cell.imageView?.kf.setImage(
                with: imageStyle.imageURL,
                placeholder: UIImage(systemName: "photo"),
                options: [.transition(.fade(0.2))]
            ) { [weak cell] _ in
                cell?.setNeedsLayout()
            }
            
        case .소리설정:
            cell.textLabel?.text = "글자 문제 읽어주기"
            cell.imageView?.image = UIImage(systemName: "speaker.wave.2")
            cell.accessoryType = .none
            
            let soundSwitch = UISwitch()
            soundSwitch.isOn = false
            soundSwitch.addAction(
                UIAction(handler: { [weak self] action in
                    self?.switchTTSOn(soundSwitch.isOn)
                }),
                for: .valueChanged
            )
            cell.accessoryView = soundSwitch
        case .자동넘김:
            if indexPath.row == selectedAutoScrollRow {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
            guard let style = SettingViewAutoScrollStyle(rawValue: indexPath.row) else {
                return cell
            }
            
            cell.textLabel?.text = "\(style.second)초"
            cell.imageView?.image = UIImage(systemName: style.systemImageName)
            
        case .version:
            cell.textLabel?.text = Bundle.marketingVersion
            cell.detailTextLabel?.text = "앱스토어로 이동"
            cell.imageView?.image = UIImage(systemName: "calendar.circle")
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection sectionIndex: Int) -> String? {
        guard let section = SettingViewSection(rawValue: sectionIndex) else { return nil }
        
        return section.title
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingViewSection(rawValue: indexPath.section) else { return }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch section {
        case .imageStyle:
            let beforeSelectedRow = selectImageIndex
            let afterSelectedRow = indexPath.item
            
            selectImageIndex = indexPath.item
            
            tableView.reloadRows(
                at: [
                    IndexPath(row: beforeSelectedRow, section: indexPath.section),
                    IndexPath(row: afterSelectedRow, section: indexPath.section)
                ],
                with: .automatic
            )
        case .자동넘김:
            let beforeSelectedRow = selectedAutoScrollRow
            let afterSelectedRow = indexPath.item
            
            selectedAutoScrollRow = indexPath.item
            
            tableView.reloadRows(
                at: [
                    IndexPath(row: beforeSelectedRow, section: indexPath.section),
                    IndexPath(row: afterSelectedRow, section: indexPath.section)
                ],
                with: .automatic
            )
            
        case .소리설정:
            break
        case .version:
            break
        }
    }
}

