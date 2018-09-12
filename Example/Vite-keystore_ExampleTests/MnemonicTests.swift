//
//  MnemonicTests.swift
//  Vite-keystore_Example
//
//  Created by Water on 2018/8/29.
//  Copyright © 2018年 Water. All rights reserved.
//

import XCTest
import CryptoSwift

@testable import Vite_keystore

class MnemonicTests: XCTestCase {
    let entropy = Data(hex: "e27b674dd7cc3b4ce67ad38d18bae592871dc7e4a7384cdcc07e1a3f9d3dcfca")
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testMenmonic() {
        let mnemonic = Mnemonic.generator(entropy: entropy)
        XCTAssertEqual(
            mnemonic,
            "tiny swamp square question senior please okay foil minimum shift ride celery impact token myth train error toward buzz crucial what page dish empower"
        )

        let seed = Mnemonic.createBIP39Seed(mnemonic: mnemonic)
        XCTAssertEqual(
            seed.toHexString(),
            "df950b950344e2341c4d76da9c87cefc0605b624fc1a93bc6548aad075b3c1c93d6df27aa7177f9d1ff64b55f2ed15f70b600298e3e88721d2246553634e98f3"
        )
    }

    func testJapaneceGeneration() {
        let mnemonic = Mnemonic.generator(entropy: entropy, language: .japanese)
        XCTAssertEqual(
            mnemonic,
            "まわす ほあん ふさい にあう はっきり とおる つつじ さくひん だむる はめつ ねまき おばさん ずほう みかん ちいき むいか こうつう みほん おうふく きどう りりく でこぼこ くれる けんすう"
        )

        let seed = Mnemonic.createBIP39Seed(mnemonic: mnemonic)
        XCTAssertEqual(
            seed.toHexString(),
            "105f8de5c554d67f38f305ec5d7e65ab54c34de406b4ba35312b1e1c11764e75474eec92a95a802c1d189789923937cf56fa8753bdf892210f30ae65bb790316"
        )
    }
    
    func testKoreanGeneration() {
        let mnemonic = Mnemonic.generator(entropy: entropy, language: .korean)
        XCTAssertEqual(
            mnemonic,
            "토마토 취향 천천히 자동 종업원 이발소 왜냐하면 비둘기 여든 주장 전문 날짜 수박 통화 영양 팩스 백성 판결 기능 독일 홍차 원숭이 몸속 발생"
        )

        let seed = Mnemonic.createBIP39Seed(mnemonic: mnemonic)
        XCTAssertEqual(
            seed.toHexString(),
            "5cc3a8623456ad338e703b9fa8fd348af720e6e1f8ab78b8d83a1384c4a484c2524160355d8efa3c1ad24de029acb1afabb753d3498c48075912c3fb9e3fb640"
        )

    }
    
    func testFrenchGeneration() {
        let mnemonic = Mnemonic.generator(entropy: entropy, language: .french)
        XCTAssertEqual(
            mnemonic,
            "sternum sérieux ruelle outrager pruneau notable mentor esquiver lettre quitter pilote buisson gestuel sucre lumière talisman éclore synapse blouson cocotier vexant morsure débutant donjon"
        )

        let seed = Mnemonic.createBIP39Seed(mnemonic: mnemonic)
        XCTAssertEqual(
            seed.toHexString(),
            "5ab8fbc424109a204b02f2aff72c61f8febc0afb69538a28e9c82359b3029418026e9e1516d83f8bbbfe70eeed18de9e939de38c7de241d8ceac0939699cfd27"
        )

    }
    
    func testItalianGeneration() {
        let mnemonic = Mnemonic.generator(entropy: entropy, language: .italian)
        XCTAssertEqual(
            mnemonic,
            "tara stacco sobbalzo rastrello scala possesso parola gallina oblio scivolo risvolto cane levigato tecnico organico tiro evoluto tettoia bozzolo crisi vigilia petalo dogma esanime"
        )
        let seed = Mnemonic.createBIP39Seed(mnemonic: mnemonic)
        XCTAssertEqual(
            seed.toHexString(),
            "46faa580cdf17fdfd29c5694b34d1e92095a9479e37a68180469d063944772c70154ca5ee7cf1412af15a221733461391243a78fc40a4587f10bfeed29c42a1e"
        )

    }
    
    func testSimplifiedChineseGeneration() {
        let mnemonic = Mnemonic.generator(entropy: entropy, language: .simplifiedChinese)
        XCTAssertEqual(
            mnemonic,
            "症 佛 眉 伍 砖 徒 恢 频 尚 详 兼 认 亮 杰 谷 焰 够 冶 先 般 戈 坡 失 充"
        )
        let seed = Mnemonic.createBIP39Seed(mnemonic: mnemonic)
        XCTAssertEqual(
            seed.toHexString(),
            "f4e2995616d286faa45d2d171525d2c24ef37799b83844dbdf25eb70f98eb3192edb958ac340e99909f55f5f54e345e047316802a28aad46f6fe6753a57028ec"
        )

    }
    
    func testTraditionalChineseGeneration() {
        let mnemonic = Mnemonic.generator(entropy: entropy, language: .traditionalChinese)
        XCTAssertEqual(
            mnemonic,
            "症 佛 眉 伍 磚 徒 恢 頻 尚 詳 兼 認 亮 傑 谷 焰 夠 冶 先 般 戈 坡 失 充"
        )
        let seed = Mnemonic.createBIP39Seed(mnemonic: mnemonic)
        XCTAssertEqual(
            seed.toHexString(),
            "3d580509ec61af79e970af889840c6dd937937af8904a7b2cf8fb6b068312895eb0807674de0dc708fc075ed0838a7c3e959f1671aed9df81f5c13af528a0b67"
        )
    }
    
    func testSpanishGeneration() {
        let mnemonic = Mnemonic.generator(entropy: entropy, language: .spanish)
        XCTAssertEqual(
            mnemonic,
            "tatuaje sopa satán pena recreo oruga neutro finito mercado reja poste burro imperio teléfono monja tierra enero testigo bocina cocción vida obtener dardo edad"
        )

        let seed = Mnemonic.createBIP39Seed(mnemonic: mnemonic)
        XCTAssertEqual(
            seed.toHexString(),
            "26e1d7631f436403047a0d35c5d560e64b6224f5db741b9b54c4ddea1569f7283837fb9bd483957db7eb5a4d2b9e4d9dadcbd1744f17474f853adc50d4ebe6c0"
        )
    }

}
