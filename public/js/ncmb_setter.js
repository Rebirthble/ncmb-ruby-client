//////////////max_valueを登録するメソッド////////////////
var set_max_value = function(max_value){
    var ShakeCount = NCMB.Object.extend("shake_count");
    var count_data = new ShakeCount();
    count_data.set("objectId","kBJKPWZhrXZ4mJF7");
    count_data.set("max_value", max_value);
    count_data.save();
};

//////////////count_valueとmax_valueとフラグをリセットするメソッド////////////////
var reset_values = function(){
    //count_valueとmax_valueをリセット
    var ShakeCount = NCMB.Object.extend("shake_count");
    var count_data = new ShakeCount();
    count_data.set("objectId","kBJKPWZhrXZ4mJF7");
    count_data.set("max_value", 0);
    count_data.set("count_value", 0);
    count_data.save();

    //フラグをリセットする
    var FlagData = NCMB.Object.extend("slot_start_flag");
    var flag_data = new FlagData();
    flag_data.set("objectId","Gg8weX5ZoD7X8WVn");
    flag_data.set("flag_value", 0);
    flag_data.save();
};

var shake_num = 0;

var num_set = function(num){
    shake_num = num;
}

var get_shake_num = function(){
    var ShakeCount = NCMB.Object.extend("shake_count");
    var query = new NCMB.Query(ShakeCount);
    var num = 0;
    var ret_data = query.get("kBJKPWZhrXZ4mJF7", {
      success: function(data) {
            console.log(data);
            num_set(data.attributes.count_value);
            console.log(shake_num);
      },
      error: function(object, error) {
        console.log(object, error);
      }
    });
    return shake_num;
}
