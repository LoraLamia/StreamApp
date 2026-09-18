//
//  SampleContent.swift
//  StreamApp
//
//  Demo catalog. Video items point at public HLS test streams; host profiles
//  use neutral placeholder portraits and have no video.
//

import Foundation

enum SampleContent {

    // MARK: - Open movies

    /// Also used directly by player previews, so it lives in one place.
    static let bigBuckBunnyStream = Stream(
        title: "Big Buck Bunny",
        url: URL(string: "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8")!
    )

    static let bigBuckBunny = MediaItem(
        id: "big-buck-bunny",
        title: bigBuckBunnyStream.title,
        subtitle: "Animation · 2008 · 10 min",
        overview: "A giant rabbit with a heart bigger than himself takes on three bullying rodents. The Blender Foundation's first open movie.",
        artwork: .sample(seed: "bigbuckbunny"),
        stream: bigBuckBunnyStream
    )

    static let tearsOfSteel = MediaItem.video(
        id: "tears-of-steel",
        title: "Tears of Steel",
        subtitle: "Sci-Fi · 2012 · 12 min",
        overview: "In a future Amsterdam a group of scientists tries to undo a heartbreak by hacking time itself. Live-action open movie by the Blender Foundation.",
        seed: "tearsofsteel",
        url: "https://test-streams.mux.dev/tos_ismc/main.m3u8"
    )

    static let elephantsDream = MediaItem.video(
        id: "elephants-dream",
        title: "Elephants Dream",
        subtitle: "Animation · 2006 · 11 min",
        overview: "Two characters explore a surreal machine world in the very first open movie ever made.",
        seed: "elephantsdream",
        url: "https://d2zihajmogu5jn.cloudfront.net/elephantsdream/hls/ed_hd.m3u8"
    )

    static let angelOne = MediaItem.video(
        id: "angel-one",
        title: "Angel One",
        subtitle: "Short · Multi-language demo",
        overview: "A short clip used by the Shaka Player team to exercise multiple audio languages and subtitle tracks.",
        seed: "angelone",
        url: "https://storage.googleapis.com/shaka-demo-assets/angel-one-hls/hls.m3u8"
    )

    static let phantomFlex4K = MediaItem.video(
        id: "phantom-flex-4k",
        title: "Phantom Flex 4K",
        subtitle: "Sports · 4K · Demo",
        overview: "Ultra-high-resolution skateboarding footage shot on a Phantom Flex camera. Handy for checking 4K playback on Apple TV.",
        seed: "skate4k",
        url: "https://sample.vodobox.net/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8"
    )

    static let jwShowcase = MediaItem.video(
        id: "jw-showcase",
        title: "JW Player Showcase",
        subtitle: "Showcase · Demo",
        overview: "Demo reel served from the JW Player CDN, useful as a third-party reference stream.",
        seed: "jwshowcase",
        url: "https://cdn.jwplayer.com/manifests/pZxWPRg4.m3u8"
    )

    // MARK: - Live channels

    static let liveChannelOne = MediaItem.video(
        id: "live-channel-1",
        title: "Live Channel 1",
        subtitle: "Live · Unified Streaming feed",
        overview: "Unified Streaming's 24/7 live test feed. The other live tiles point at the same feed so the row has several entries to switch between.",
        seed: "livechannel1",
        url: "https://demo.unified-streaming.com/k8s/live/stable/scte35.isml/.m3u8",
        isLive: true
    )

    static let liveChannelTwo = MediaItem.video(
        id: "live-channel-2",
        title: "Live Channel 2",
        subtitle: "Live · Unified Streaming feed",
        overview: "Same Unified Streaming live feed under a second tile.",
        seed: "livechannel2",
        url: "https://demo.unified-streaming.com/k8s/live/stable/scte35.isml/.m3u8",
        isLive: true
    )

    static let liveChannelThree = MediaItem.video(
        id: "live-channel-3",
        title: "Live Channel 3",
        subtitle: "Live · Unified Streaming feed",
        overview: "Same Unified Streaming live feed under a third tile.",
        seed: "livechannel3",
        url: "https://demo.unified-streaming.com/k8s/live/stable/scte35.isml/.m3u8",
        isLive: true
    )

    static let unifiedLive = MediaItem.video(
        id: "unified-live",
        title: "Unified Streaming Live",
        subtitle: "Live · SCTE-35 markers",
        overview: "Live test channel that carries ad-insertion markers, good for testing discontinuities in a live playlist.",
        seed: "unifiedlive",
        url: "https://demo.unified-streaming.com/k8s/live/stable/scte35.isml/.m3u8",
        isLive: true
    )

    // MARK: - Engineering test streams

    static let appleAdvanced = MediaItem.video(
        id: "apple-advanced-fmp4",
        title: "Apple Advanced (fMP4)",
        subtitle: "Test · fMP4 · Multiple audio tracks",
        overview: "Apple's reference stream with fragmented MP4 segments, several audio tracks and subtitles.",
        seed: "appleadv",
        url: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8"
    )

    static let appleBipBop = MediaItem.video(
        id: "apple-bipbop-16x9",
        title: "Apple Bip-Bop 16:9",
        subtitle: "Test · MPEG-TS segments",
        overview: "The classic Apple HLS example with a ticking clock overlay, MPEG-TS segments and several bitrates.",
        seed: "bipbop",
        url: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8"
    )

    static let aesEncrypted = MediaItem.video(
        id: "mux-aes-128",
        title: "AES-128 Encrypted",
        subtitle: "Test · Encrypted segments",
        overview: "Big Buck Bunny with AES-128 segment encryption, for checking that key delivery works.",
        seed: "aes128",
        url: "https://test-streams.mux.dev/bbbAES/playlists/sample_aes/index.m3u8"
    )

    static let ptsShift = MediaItem.video(
        id: "mux-pts-shift",
        title: "PTS Shift",
        subtitle: "Test · Timestamps",
        overview: "Stream whose presentation timestamps jump, for testing timeline handling.",
        seed: "ptsshift",
        url: "https://test-streams.mux.dev/pts_shift/master.m3u8"
    )

    static let adDiscontinuity = MediaItem.video(
        id: "mux-dai-discontinuity",
        title: "Ad Insertion Discontinuity",
        subtitle: "Test · Discontinuities",
        overview: "Playlist with discontinuity tags around inserted ads, from a real broadcaster setup.",
        seed: "discontinuity",
        url: "https://test-streams.mux.dev/dai-discontinuity-deltatre/manifest.m3u8"
    )

    static let segmentGap = MediaItem.video(
        id: "segment-gap",
        title: "Segment Gap Test",
        subtitle: "Test · Missing segments",
        overview: "Tiny stream with a deliberate gap between segments, to see how the player recovers.",
        seed: "segmentgap",
        url: "https://mtoczko.github.io/hls-test-streams/test-gap/playlist.m3u8"
    )

    // MARK: - Hosts (image only)

    static let hosts: [MediaItem] = [
        .profile(id: "host-mia", name: "Mia Novak", role: "Host · Morning Brief",
                 bio: "Kicks off the day with headlines and interviews every weekday morning.", portrait: 44),
        .profile(id: "host-lena", name: "Lena Fischer", role: "Host · Tech Hour",
                 bio: "Breaks down the week's technology news with guests from the industry.", portrait: 68),
        .profile(id: "host-sofia", name: "Sofia Rossi", role: "Host · Cinema Club",
                 bio: "Curates and introduces the films in the Open Movies collection.", portrait: 21),
        .profile(id: "host-ana", name: "Ana Kovač", role: "Host · Live Sports Desk",
                 bio: "Anchors the live sports coverage and post-game analysis.", portrait: 33),
        .profile(id: "host-emma", name: "Emma Laurent", role: "Host · Culture Weekly",
                 bio: "Talks to artists, authors and musicians about what they are making right now.", portrait: 57),
        .profile(id: "host-nora", name: "Nora Jensen", role: "Host · Science Now",
                 bio: "Explains new research in plain language, one discovery at a time.", portrait: 12),
        .profile(id: "host-ivy", name: "Ivy Chen", role: "Host · Night Session",
                 bio: "Late-night conversations and live music from the studio.", portrait: 75),
        .profile(id: "host-zoe", name: "Zoe Martin", role: "Host · Weekend Edition",
                 bio: "Rounds up the week and previews what is coming next.", portrait: 90),
    ]

    // MARK: - Rows

    static let sections: [CatalogSection] = [
        CatalogSection(id: "trending", title: "Trending Now", layout: .landscape,
                       items: [tearsOfSteel, bigBuckBunny, liveChannelOne, phantomFlex4K, angelOne, elephantsDream]),
        CatalogSection(id: "open-movies", title: "Open Movies", layout: .poster,
                       items: [bigBuckBunny, elephantsDream, tearsOfSteel, angelOne, jwShowcase, phantomFlex4K]),
        CatalogSection(id: "live", title: "Live Channels", layout: .landscape,
                       items: [liveChannelOne, liveChannelTwo, liveChannelThree, unifiedLive]),
        CatalogSection(id: "hosts", title: "Featured Hosts", layout: .circle,
                       items: hosts),
        CatalogSection(id: "engineering", title: "Engineering Test Streams", layout: .landscape,
                       items: [appleAdvanced, appleBipBop, aesEncrypted, ptsShift, adDiscontinuity, segmentGap]),
    ]
}

// MARK: - Factories

private extension MediaItem {

    static func video(
        id: String,
        title: String,
        subtitle: String,
        overview: String,
        seed: String,
        url: String,
        isLive: Bool = false
    ) -> MediaItem {
        MediaItem(
            id: id,
            title: title,
            subtitle: subtitle,
            overview: overview,
            artwork: .sample(seed: seed),
            stream: Stream(title: title, url: URL(string: url)!, isLive: isLive)
        )
    }

    /// Image-only entry. `portrait` picks one of randomuser.me's placeholder
    /// headshots (0...99).
    static func profile(id: String, name: String, role: String, bio: String, portrait: Int) -> MediaItem {
        MediaItem(
            id: id,
            title: name,
            subtitle: role,
            overview: bio,
            artwork: .remote(URL(string: "https://randomuser.me/api/portraits/women/\(portrait).jpg")!),
            stream: nil
        )
    }
}
