import UIKit
import SnapKit
import Kingfisher

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

final class SettingViewController: BaseViewController {
    typealias Cell = UITableViewCell

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var selectImageIndex: Int = 0
    private var selectedAutoScrollRow: Int = 0

    private var appVersionText: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        #if DEBUG
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        if let version, let build { return "v\(version) (\(build))" }
        #else
        if let version { return "v\(version)" }
        #endif
        return "버전 정보"
    }

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
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "실사 스타일"
                let url = URL(string: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/realistic/swan.webp")
                cell.imageView?.kf.setImage(with: url)
            case 1:
                cell.textLabel?.text = "3D 장난감 스타일"
                let url = URL(string: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/toy3D/lion.webp")
                cell.imageView?.kf.setImage(with: url)
                
            case 2:
                cell.textLabel?.text = "2D 애니메이션 스타일"
                let url = URL(string: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/toy3D/lion.webp")
                cell.imageView?.kf.setImage(with: url)
            case 3:
                cell.textLabel?.text = "봉제 인형 스타일"
                let url = URL(string: "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/plush/tiger.webp")
                cell.imageView?.kf.setImage(with: url)
            default:
                cell.textLabel?.text = ""
                cell.imageView?.image = nil
                cell.accessoryType = .none
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
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "1초"
                cell.imageView?.image = UIImage(systemName: "1.brakesignal")
            case 1:
                cell.textLabel?.text = "3초"
                cell.imageView?.image = UIImage(systemName: "3.circle")
            case 2:
                cell.textLabel?.text = "5초"
                cell.imageView?.image = UIImage(systemName: "5.arrow.trianglehead.clockwise")
            case 3:
                cell.textLabel?.text = "10초"
                cell.imageView?.image = UIImage(systemName: "10.arrow.trianglehead.clockwise")
            default:
                cell.textLabel?.text = "5초"
                cell.imageView?.image = UIImage(systemName: "ellipsis.circle")
            }
        case .version:
            cell.textLabel?.text = appVersionText
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
