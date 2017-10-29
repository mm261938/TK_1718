# NEWS×MAP

[![Product Name](https://raw.github.com/GabLeRoux/WebMole/master/ressources/WebMole_Youtube_Video.png)](https://www.youtube.com/watch?v=aZxTgMs1y7Y)

## 製品概要
### ニュース地図 Tech
一体、どこで何が起きているのだろうと疑問を抱いたことはありませんか？

### 背景（製品開発のきっかけ、課題等）

製品の企画で議論を始める際に、話し合いのぶれない軸を定めるためには、開発テーマの決定が最重要だと考えられます。しかし、新しい社会問題、あるいは斬新な解決策を考慮して、立案する手がかりをつかむことは最も難しいです。そこで、新しい問題に気付けるキッカケ作りの道具が欲しいと願い、具体的に学生が大学のレポートや研究等で重要なテーマを決めるためには、どうしたら良いのかと考えたことが、本製品を開発するきっかけとなりました。

- 「新しい情報をいつでも・どこでも・手軽に入手したい」と一度は皆さん思ったことがあるのではないでしょうか？

ニュースアプリを携帯やPCに追加して、WEBニュースを積極的に閲覧するようになった経験があるのではないかと思います。
しかしながら、忙しかったり疲れていたりすると、ついつい閲覧する機会が減ってしまいます。そこで、学生に着目した時に2つの課題が考えられました。

- 第1に、学生の意識の低さです。
  
2016年6月中旬から選挙法の改正により「20歳以上の男女」から「18歳以上の男女」に変更されました。
選挙権年齢が引き下がった一方で、若者の投票率はどの世代よりも低く、若者の政治離れが懸念されています。
そんな若者にも世界や政治を身近に感じていただきたいのです。
  
- 第2に、学生の視野の狭さです。

「最近の若者は視野が狭くなっている」という大人の意見が世間から見た若者の現状です。
「自分の無知を恥じることなく、知らないことは自分には関係ない」と捉えているからです。
そんな若者の傾向の1つとして、
「広い世界を見ると、自分がちっぽけで無力に感じてしまうから、自分が傷つかないように、外の世界との繋がりを避けている。」
が考えられ、若者はどうしても自分の興味や関係のあるものだけに目を向けてしまいます。
その結果、自然に他人への配慮を考えなくなり、視野の狭さを促進させているのです。
   
自分の小さなコミュニティの中だけに満足せず、ニュースを世界規模で見れるようになると視野を広げるきっかけになると考えました。
また、視野を広げることで新たなイノベーションに繋げられるのではないでしょうか。

### 製品説明（具体的な製品の説明）

＊実装した機能
- 地図上に各ニュースを配置。
- 各ニュースは2文くらいに要約して表示する。
- リンクからそのニュースの詳細に飛ぶ。

従来の既存製品である「みんなの経済新聞」には、次のような問題がありました。

- 地域の話題性が中心となり、社会問題に焦点が当たっていない点。
- 情報が日本に集中してしまっていて、世界単位での情報収集ができない点。
- 地域に限られていて、国や都市での問題でニュース同士の関連性を見出せない点。
- 記事の見出しでは、一目で内容が理解できない点。
- 地域ごとの地図しか見れず、世界の全体像が把握できない点。

### 特長

#### 1. 世界の新しい社会問題が浮き彫りにできる
世界単位で社会問題に焦点を当て、国や都市での問題をピックアップする事で他国との関連性を見出して視野の拡大を促すような作り。

#### 2. デザインが頭に突き刺さる衝撃を与える
世界地図の全体像を一面で見れるようにする事で見やすさに加え、顧客の好奇心を引き立てる。

#### 3. ニュースの内容が一目で理解できる
ニュース記事の問題点を要約して表示する事で、一目で内容を簡単に理解できる。

最近の若者の傾向の改善にも務めたいという願いを込めて、NEWS✕MAPを開発しました。

### 解決出来ること
本開発の成果は、学生の意欲、社会貢献や様々なイノベーターの動機作りが期待される。

### 今後の展望
現在は、最新の記事を優先させているが、記事の重要度を他にも設定できるようにする事が今後の課題です。例えば以下の事が考えられます。
- 論理演算のANDやOR、NOTが使用可能にする
- キーワードの抽出で記事が検索できる
- 閲覧数順でランキングが表示される
- 類字するキーワードの多さ順に並び変える
- 注目されずに埋もれている新しい社会問題は機械学習で推定する
他には、パッと見てわかるシンプルなデザイン性を追求する等の課題が山積している


## 開発内容・開発技術
### 活用した技術
#### API・データ
* [文章要約API(sdon)](http://www.47news.jp/cgi-bin/ra/editor/editor.cgi)
* [Google News 取得API](http://tomehachi.sakura.ne.jp/blog/archives/486)
* [Google地図API](https://developers.google.com/maps/?hl=ja)

#### フレームワーク・ライブラリ・モジュール
* サーバ: Amazon Web Services
  * Rack Webサーバー: Unicorn
  * Webサーバー: Nginx
  * フレームワーク: Rails
* Ruby on Rails
  * Ruby: v2.4.0
  * Rails: v5.1.4
* DB: MySQL2

#### デバイス
* Webアプリケーション

### 研究内容・事前開発プロダクト（任意）
なし

### 独自開発技術（Hack Dayで開発したもの）
#### 2日間に開発した独自の機能・技術
* 独自で開発したものの内容をこちらに記載してください
* 特に力を入れた部分をファイルリンク、またはcommit_idを記載してください（任意）
