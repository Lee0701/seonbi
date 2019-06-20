{-# LANGUAGE OverloadedLists #-}
{-# LANGUAGE OverloadedStrings #-}
module Text.Seonbi.HanjaSpec (spec) where

import Test.Hspec

import Text.Seonbi.Hanja
import Text.Seonbi.Html

inputFixture :: [HtmlEntity]
inputFixture =
    [ HtmlStartTag [] H1 ""
    , HtmlText [H1] "異蹟"
    , HtmlEndTag [] H1
    , HtmlStartTag [] P ""
    , HtmlText [P] "발에 터분한 것을 다 빼어 바리고"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "黃昏이 湖水우로 걸어 오듯이"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "나도 삽분삽분 걸어 보리이까?"
    , HtmlEndTag [] P
    , HtmlStartTag [] P ""
    , HtmlText [P] "내사 이 湖水가로"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "부르는 이 없이"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "불리워 온것은"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "참말 異蹟이외다."
    , HtmlEndTag [] P
    , HtmlStartTag [] P ""
    , HtmlText [P] "오늘 따라"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "戀情, 自惚, 猜忌, 이것들이"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "자꼬 金메달처럼 만져지는구려"
    , HtmlEndTag [] P
    , HtmlStartTag [] P ""
    , HtmlText [P] "하나, 내 모든 것을 餘念없이"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "물결에 써서 보내려니"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "당신은 湖面으로 나를 불러 내소서."
    , HtmlEndTag [] P
    ]

outputFixture :: [HtmlEntity]
outputFixture =
    [ HtmlStartTag [] H1 ""
    , HtmlText [H1] "리적"
    , HtmlEndTag [] H1
    , HtmlStartTag [] P ""
    , HtmlText [P] "발에 터분한 것을 다 빼어 바리고"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "황혼이 호수우로 걸어 오듯이"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "나도 삽분삽분 걸어 보리이까?"
    , HtmlEndTag [] P
    , HtmlStartTag [] P ""
    , HtmlText [P] "내사 이 호수가로"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "부르는 이 없이"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "불리워 온것은"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "참말 리적이외다."
    , HtmlEndTag [] P
    , HtmlStartTag [] P ""
    , HtmlText [P] "오늘 따라"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "련정, 자홀, 시기, 이것들이"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "자꼬 금메달처럼 만져지는구려"
    , HtmlEndTag [] P
    , HtmlStartTag [] P ""
    , HtmlText [P] "하나, 내 모든 것을 여념없이"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "물결에 써서 보내려니"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "당신은 호면으로 나를 불러 내소서."
    , HtmlEndTag [] P
    ]

outputWithInitialSoundLawFixture :: [HtmlEntity]
outputWithInitialSoundLawFixture =
    [ HtmlStartTag [] H1 ""
    , HtmlText [H1] "이적"
    , HtmlEndTag [] H1
    , HtmlStartTag [] P ""
    , HtmlText [P] "발에 터분한 것을 다 빼어 바리고"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "황혼이 호수우로 걸어 오듯이"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "나도 삽분삽분 걸어 보리이까?"
    , HtmlEndTag [] P
    , HtmlStartTag [] P ""
    , HtmlText [P] "내사 이 호수가로"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "부르는 이 없이"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "불리워 온것은"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "참말 이적이외다."
    , HtmlEndTag [] P
    , HtmlStartTag [] P ""
    , HtmlText [P] "오늘 따라"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "연정, 자홀, 시기, 이것들이"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "자꼬 금메달처럼 만져지는구려"
    , HtmlEndTag [] P
    , HtmlStartTag [] P ""
    , HtmlText [P] "하나, 내 모든 것을 여념없이"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "물결에 써서 보내려니"
    , HtmlStartTag [P] BR "", HtmlEndTag [P] BR
    , HtmlText [P] "당신은 호면으로 나를 불러 내소서."
    , HtmlEndTag [] P
    ]

spec :: Spec
spec = do
    describe "phoneticizeHanjaChar" $ do
        it "returns the input as is if not a Hanja character" $ do
            phoneticizeHanjaChar 'A' `shouldBe` 'A'
            phoneticizeHanjaChar '가' `shouldBe` '가'
        it "returns the most frequent way to read" $ do
            phoneticizeHanjaChar '金' `shouldBe` '금'
            phoneticizeHanjaChar '北' `shouldBe` '북'
        it "does not follow Initial Sound Law" $ do
            phoneticizeHanjaChar '六' `shouldBe` '륙'
            phoneticizeHanjaChar '禮' `shouldBe` '례'
    describe "phoneticizeHanjaWord" $ do
        it "returns the input as is if there are no Hanja at all" $ do
            phoneticizeHanjaWord "foo" `shouldBe` "foo"
            phoneticizeHanjaWord "테스트" `shouldBe` "테스트"
        it "transforms Hanja chars into the corresponding Hangul readings" $ do
            phoneticizeHanjaWord "漢字" `shouldBe` "한자"
            phoneticizeHanjaWord "言文" `shouldBe` "언문"
            phoneticizeHanjaWord "餘念" `shouldBe` "여념"
            phoneticizeHanjaWord "來日" `shouldBe` "래일"
            phoneticizeHanjaWord "未來" `shouldBe` "미래"
            phoneticizeHanjaWord "良質" `shouldBe` "량질"
            phoneticizeHanjaWord "力量" `shouldBe` "력량"
    describe "phoneticizeHanjaWordWithInitialSoundLaw" $ do
        let phone = phoneticizeHanjaWordWithInitialSoundLaw
        it "returns the input as is if there are no Hanja at all" $ do
            phone "foo" `shouldBe` "foo"
            phone "테스트" `shouldBe` "테스트"
        it "transforms Hanja chars into the corresponding Hangul readings" $ do
            phone "漢字" `shouldBe` "한자"
            phone "言文" `shouldBe` "언문"
            phone "餘念" `shouldBe` "여념"
            phone "未來" `shouldBe` "미래"
            phone "法律" `shouldBe` "법률"
            phone "一列" `shouldBe` "일렬"
        it "converts the first letter according to Initial Sound Law" $ do
            phone "來日" `shouldBe` "내일"
            phone "良質" `shouldBe` "양질"
            phone "力量" `shouldBe` "역량"
        it ("converts a letter followed by no batchim or nieun (N) according "
            ++ "to Initial Sound Law") $ do
            phone "羅列" `shouldBe` "나열"
            phone "序列" `shouldBe` "서열"
            phone "義烈" `shouldBe` "의열"
            phone "規律" `shouldBe` "규율"
            phone "煨栗" `shouldBe` "외율"
            phone "自律" `shouldBe` "자율"
            phone "卑劣" `shouldBe` "비열"
            phone "優劣" `shouldBe` "우열"
            phone "熾烈" `shouldBe` "치열"
            phone "比率" `shouldBe` "비율"
            phone "利率" `shouldBe` "이율"
            phone "棗栗" `shouldBe` "조율"
            phone "分裂" `shouldBe` "분열"
            phone "前列" `shouldBe` "전열"
            phone "百分率" `shouldBe` "백분율"
            phone "韻律" `shouldBe` "운율"
            phone "煥率" `shouldBe` "환율"
            phone "分列" `shouldBe` "분열"
            phone "先烈" `shouldBe` "선열"
            phone "賤劣" `shouldBe` "천열"
            phone "旋律" `shouldBe` "선율"
            phone "戰慄" `shouldBe` "전율"
        it "converts all Hanja digits according to Initial Sound Law" $ do
            phone "千九百八十六年" `shouldBe` "천구백팔십육년"
            phone "第六共和國" `shouldBe` "제육공화국"
            phone "拾萬圓" `shouldBe` "십만원"
            phone "參佰拾圓" `shouldBe` "삼백십원"
            phone "仟參佰圓" `shouldBe` "천삼백원"
    describe "phoneticizeHanja" $ do
        specify "without initial sound law" $
            normalizeText (phoneticizeHanja phoneticizeHanjaWord inputFixture)
                `shouldBe` normalizeText outputFixture
        specify "with initial sound law" $ do
            let phone = phoneticizeHanja phoneticizeHanjaWordWithInitialSoundLaw
            let phone' = normalizeText . phone
            phone' inputFixture `shouldBe`
                normalizeText outputWithInitialSoundLawFixture
            phone' [HtmlText [] "1996年 그들이 地球를 支配했을 때"] `shouldBe`
                [HtmlText [] "1996년 그들이 지구를 지배했을 때"]
    describe "convertInitialSoundLaw" $ do
        specify "녀, 뇨, 뉴, 니 should be 여, 요, 유, 이" $ do
            convertInitialSoundLaw '녀' `shouldBe` '여'
            convertInitialSoundLaw '뉴' `shouldBe` '유'
            convertInitialSoundLaw '년' `shouldBe` '연'
            convertInitialSoundLaw '니' `shouldBe` '이'
            convertInitialSoundLaw '뇨' `shouldBe` '요'
            convertInitialSoundLaw '닉' `shouldBe` '익'
        specify "랴, 려, 례, 료, 류, 리 should be 야, 여, 예, 요, 유, 이" $ do
            convertInitialSoundLaw '량' `shouldBe` '양'
            convertInitialSoundLaw '룡' `shouldBe` '용'
            convertInitialSoundLaw '력' `shouldBe` '역'
            convertInitialSoundLaw '류' `shouldBe` '유'
            convertInitialSoundLaw '례' `shouldBe` '예'
            convertInitialSoundLaw '림' `shouldBe` '임'
        specify "라, 래, 로, 뢰, 루, 르 should be 나, 내, 노, 뇌, 누, 느" $ do
            convertInitialSoundLaw '락' `shouldBe` '낙'
            convertInitialSoundLaw '뢰' `shouldBe` '뇌'
            convertInitialSoundLaw '래' `shouldBe` '내'
            convertInitialSoundLaw '루' `shouldBe` '누'
            convertInitialSoundLaw '로' `shouldBe` '노'
            convertInitialSoundLaw '릉' `shouldBe` '능'
    specify "revertInitialSoundLaw" $ do
        revertInitialSoundLaw '여' `shouldBe` ['녀', '려']
        revertInitialSoundLaw '유' `shouldBe` ['뉴', '류']
        revertInitialSoundLaw '연' `shouldBe` ['년', '련']
        revertInitialSoundLaw '이' `shouldBe` ['니', '리']
        revertInitialSoundLaw '요' `shouldBe` ['뇨', '료']
        revertInitialSoundLaw '입' `shouldBe` ['닙', '립']
        revertInitialSoundLaw '양' `shouldBe` ['량']
        revertInitialSoundLaw '예' `shouldBe` ['례']
        revertInitialSoundLaw '낙' `shouldBe` ['락']
        revertInitialSoundLaw '뇌' `shouldBe` ['뢰']
        revertInitialSoundLaw '내' `shouldBe` ['래']
        revertInitialSoundLaw '누' `shouldBe` ['루']
        revertInitialSoundLaw '노' `shouldBe` ['로']
        revertInitialSoundLaw '능' `shouldBe` ['릉']
