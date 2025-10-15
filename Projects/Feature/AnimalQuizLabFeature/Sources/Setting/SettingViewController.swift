import UIKit
import SnapKit

enum SettingViewSection: CaseIterable {
    case imageStyle
    case 자동넘김
    case version
}

final class SettingViewController: BaseViewController {
    typealias Cell = UITableViewCell

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var selectImageIndex: Int = 0

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
}

private extension SettingViewController {
    func section(for index: Int) -> SettingViewSection? {
        guard index >= 0, index < SettingViewSection.allCases.count else { return nil }
        return SettingViewSection.allCases[index]
    }
}

extension SettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingViewSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
        guard let section = self.section(for: sectionIndex) else { return 0 }
        switch section {
        case .imageStyle:
            return 4
        case .자동넘김:
            return 1
        case .version:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let section = section(for: indexPath.section) else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        switch section {
        case .imageStyle:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "실사 스타일"
                cell.imageView?.image = UIImage(systemName: "photo")
                cell.accessoryType = .checkmark
            case 1:
                cell.textLabel?.text = "3D 장난감 스타일"
                cell.imageView?.image = UIImage(systemName: "photo.on.rectangle")
                cell.accessoryType = .none
            case 2:
                cell.textLabel?.text = "2D 애니메이션 스타일"
                cell.imageView?.image = UIImage(systemName: "photo.on.rectangle")
                cell.accessoryType = .none
            case 3:
                cell.textLabel?.text = "봉제 인형 스타일"
                cell.imageView?.image = UIImage(systemName: "photo.on.rectangle")
                cell.accessoryType = .none
            default:
                cell.textLabel?.text = ""
                cell.imageView?.image = nil
                cell.accessoryType = .none
            }
        case .자동넘김:
            cell.textLabel?.text = "자동 넘김 옵션"
            cell.imageView?.image = UIImage(systemName: "arrow.triangle.2.circlepath")
            cell.accessoryType = .detailDisclosureButton
        case .version:
            cell.textLabel?.text = "v1.0.0"
            cell.imageView?.image = UIImage(systemName: "calendar.circle")
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection sectionIndex: Int) -> String? {
        guard let section = self.section(for: sectionIndex) else { return nil }
        switch section {
        case .imageStyle:
            return "이미지 스타일"
        case .자동넘김:
            return "자동 넘김"
        case .version:
            return "버전 정보"
        }
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
