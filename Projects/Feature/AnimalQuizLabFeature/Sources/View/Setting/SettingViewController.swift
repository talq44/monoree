import UIKit
import SnapKit
import Kingfisher
import FoundationShared

enum SettingViewSection: Int, CaseIterable {
    case imageStyle = 0
    case soundSetting
    case autoScroll
    case version
    
    var title: String {
        switch self {
        case .imageStyle: return AnimalQuizLabFeatureStrings.imageStyle
        case .autoScroll: return AnimalQuizLabFeatureStrings.autoScrollSetting
        case .soundSetting: return AnimalQuizLabFeatureStrings.soundSetting
        case .version: return AnimalQuizLabFeatureStrings.versionInfo
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
        case .realistic: return AnimalQuizLabFeatureStrings.realisticStyle
        case .toy3D: return AnimalQuizLabFeatureStrings.toy3dStyle
        case .anime2D: return AnimalQuizLabFeatureStrings.anime2dStyle
        case .plush: return AnimalQuizLabFeatureStrings.plushStyle
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
        
        title = AnimalQuizLabFeatureStrings.setting
        
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
        case .soundSetting:
            return 1
        case .autoScroll:
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
                cell.textLabel?.text = AnimalQuizLabFeatureStrings.unknown
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
            
        case .soundSetting:
            cell.textLabel?.text = AnimalQuizLabFeatureStrings.readTextProblem
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
        case .autoScroll:
            if indexPath.row == selectedAutoScrollRow {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
            guard let style = SettingViewAutoScrollStyle(rawValue: indexPath.row) else {
                return cell
            }
            
            cell.textLabel?.text = AnimalQuizLabFeatureStrings.secondsFormat(style.second)
            cell.imageView?.image = UIImage(systemName: style.systemImageName)
            
        case .version:
            cell.textLabel?.text = Bundle.marketingVersion
            cell.detailTextLabel?.text = AnimalQuizLabFeatureStrings.goToAppStore
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
        case .autoScroll:
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
            
        case .soundSetting:
            break
        case .version:
            break
        }
    }
}

