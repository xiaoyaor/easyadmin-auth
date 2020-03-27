<?php

namespace addons\auth;

use app\common\library\Menu;
use think\Addons;
use think\facade\Log;
use think\facade\Config;
use think\facade\View;

/**
 * 登录背景图插件
 */
class Auth extends Addons
{

    /**
     * 插件安装方法
     * @return bool
     */
    public function install()
    {
        return true;
    }

    /**
     * 插件卸载方法
     * @return bool
     */
    public function uninstall()
    {
        return true;
    }

    /**
     * 插件启用方法
     */
    public function enable()
    {
        Menu::enable('auth');
    }

    /**
     * 插件禁用方法
     */
    public function disable()
    {
        Menu::disable('auth');
    }

    /**
     * 控制台显示插件信息
     * 可复制dashboard函数内容到此处自己改写
     * @throws \think\Exception
     */
    public function fetchToDashboard($params)
    {
        return $this->dashboard($params);
    }

    /**
     * 权限系统开启判断
     * @return boolean
     */
    public function Auth()
    {
        return true;
    }

    /**
     * 是否开启验证码
     * @return boolean
     */
    public function useCaptcha()
    {
        $config = $this->getConfig();
        if ($config['captcha'] == 'true')
        {
            return true;
        }
        return false;
    }

}
