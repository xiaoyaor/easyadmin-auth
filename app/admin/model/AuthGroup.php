<?php

namespace addons\auth\app\admin\model;

use think\Model;

class AuthGroup extends Model
{

    // 表名
    protected $name = 'auth_group';
    // 开启自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';

    public function getNameAttr($value, $data)
    {
        return __($value);
    }

}
