public class SearchCommon {

    /**
     * キーワード入力を検索語に変換
     */
    public static String convertSearchKeyword(String input, Boolean isAnd){
        String result='';
        // 全角スペース　⇒　半角　＆　トリム
        String tmp = input.replace('　', ' ').trim();
        // 重複スペース　⇒　単一
        tmp = tmp.replaceAll('  +', ' ');
        // SOSL予約語の訂正
        tmp = replaceSoslReservedChar(tmp);
        // スペースで分割
        String[] keys = tmp.split(' ');
        // キーワードがなければ終了
        if(keys.size()==0 || (keys.size()==1 && String.isBlank(keys[0]))) return result;
        // 演算子
        String opr = isAnd ? ' AND ' : ' OR ';
        // 検索語作成
        for(String key : keys){
            tmp = '"' + key + '"';
            result += (result != '' ? opr : '') + tmp;
        }
        // 終了
        return result;
    }

    /**
     * キーワード入力からリストを取得
     */
    public static String[] getSearchKeywords(String input, Boolean isAnd){
        // 全角スペース　⇒　半角　＆　トリム
        String tmp = input.replace('　', ' ').trim();
        // 重複スペース　⇒　単一
        tmp = tmp.replaceAll('  +', ' ');
        // スペースで分割
        String[] result = tmp.split(' ');
        // 終了
        return result;
    }

    /**
     * SOSL予約文字の削除
     */
    private static String replaceSoslReservedChar(String str){
        String[] reserved = new String[]{'\\', '?', '&', '|', '!', '{', '}', '[', ']', '(', ')',
            '^', '~', '*', ':', '"', '\'', '+', '-'};
        for(String s : reserved){
            str = str.replace(s, '');// 予約文字削除
        }
        return str;
    }
}