<?php

namespace addons\auth\app\admin\model;

use think\Cache;
use think\Model;

class AuthRule extends Model
{

    // 表名
    protected $name = 'auth_rule';
    // 开启自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';

    public static function onAfterWrite($user)
    {
        Cache()->delete('__menu__');
    }

    public function getTitleAttr($value, $data)
    {
        return __($value);
    }

}
