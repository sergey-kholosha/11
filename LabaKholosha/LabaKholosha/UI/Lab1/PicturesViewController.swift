//
//  PicturesViewController.swift
//  LabaKholosha

import UIKit

class PicturesViewController: UIViewController {

    private enum Constants {
        static let minIndex = 0
        static let maxIndex = 5
    }

    private struct State {
        var index: Int = 0
    }

    private var state = State() {
        didSet {
            updateUI()
        }
    }

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    private func updateUI() {
        nextButton.isEnabled = state.index < Constants.maxIndex
        previousButton.isEnabled = state.index > Constants.minIndex
        imageView.image = UIImage(named: "pictures/\(state.index)")
    }

}

// MARK: - Actions
extension PicturesViewController {

    @IBAction func didTapNext() {
        state.index = calculatedIndex(from: state.index + 1)
    }

    @IBAction func didTapPrevious() {
        state.index = calculatedIndex(from: state.index - 1)
    }

    private func calculatedIndex(from index: Int) -> Int {
        return (min(max(Constants.minIndex, index), Constants.maxIndex))
    }

}
