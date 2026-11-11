import SwiftUI
import Foundation
import ActivityKit

extension UserDefaults {
    static var main: UserDefaults {
        UserDefaults(suiteName: "group.sh.cider.CiderRemote") ?? .standard
    }
}

extension Color {
    static let cider = Color("CiderColor")
}

enum ConnectionMethod: String, Codable {
    case lan
    case tunnel
}

struct Device: Identifiable, Codable, Hashable {
    let id: UUID
    let host: String
    let token: String
    let friendlyName: String
    let connectionMethod: ConnectionMethod
    var isActive: Bool

    init(id: UUID = UUID(), host: String, token: String, friendlyName: String, connectionMethod: ConnectionMethod = .lan, isActive: Bool = false) {
        self.id = id
        self.host = host
        self.token = token
        self.friendlyName = friendlyName
        self.connectionMethod = connectionMethod
        self.isActive = isActive
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Device, rhs: Device) -> Bool {
        lhs.id == rhs.id
    }
}

struct Track: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let artist: String
    let album: String
    let artwork: String
    let duration: Double
    let artworkData: Data

    init(id: String = UUID().uuidString, title: String, artist: String, album: String = "", artwork: String = "", duration: Double = 0, artworkData: Data = Data()) {
        self.id = id
        self.title = title
        self.artist = artist
        self.album = album
        self.artwork = artwork
        self.duration = duration
        self.artworkData = artworkData
    }
}

struct LiveActivityManager {
    struct DisplayingTrack: Identifiable, Codable, Equatable {
        let id: String
        let title: String
        let artist: String
        let artworkURL: URL?

        init(title: String, artist: String, artworkURL: URL? = nil) {
            self.id = UUID().uuidString
            self.title = title
            self.artist = artist
            self.artworkURL = artworkURL
        }

        init(from track: Track) {
            self.id = track.id
            self.title = track.title
            self.artist = track.artist
            self.artworkURL = URL(string: track.artwork)
        }
    }
}
