<?php

namespace addons\auth\app\admin\controller\auth;

use addons\base\app\admin\controller\AppBackend;
use addons\auth\app\admin\model\AuthRule;
use app\common\controller\Backend;
use easy\Tree;
use think\facade\Cache;
use think\facade\View;

/**
 * 规则管理
 *
 * @icon fa fa-list
 * @remark 规则通常对应一个控制器的方法,同时左侧的菜单栏数据也从规则中体现,通常建议通过控制台进行生成规则节点
 */
class Rule extends AppBackend
{

    /**
     * @var \addons\auth\app\admin\model\AuthRule
     */
    protected $model = null;
    protected $rulelist = [];
    protected $multiFields = 'ismenu,status';

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new AuthRule();
        // 必须将结果集转换为数组
        $ruleList = collection($this->model->order('weigh', 'desc')->order('id', 'asc')->select())->toArray();
        foreach ($ruleList as $k => &$v) {
            $v['title'] = __($v['title']);
            $v['remark'] = __($v['remark']);
        }
        unset($v);
        Tree::instance()->init($ruleList);
        $this->rulelist = Tree::instance()->getTreeList(Tree::instance()->getTreeArray(0), 'title');
        $ruledata = [0 => __('None')];
        foreach ($this->rulelist as $k => &$v) {
            if (!$v['ismenu']) {
                continue;
            }
            $ruledata[$v['id']] = $v['title'];
        }
        unset($v);
        $this->assign('ruledata', $ruledata);
    }

    /**
     * 查看
     * @throws \Exception
     */
    public function index()
    {
        if (request()->isAjax()) {
            $list = $this->rulelist;
            $total = count($this->rulelist);

            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->fetch();
    }

    /**
     * 添加
     * @throws \Exception
     */
    public function add()
    {
        if (request()->isPost()) {
            //$this->token();
            $params = request()->post("row/a", [], 'strip_tags');
            if ($params) {
                if (!$params['ismenu'] && !$params['pid']) {
                    $this->error(__('The non-menu rule must have parent'));
                }
                $result = $this->model->save($params);//->validate()
                if ($result === false) {
                    $this->error($this->model->getError());
                }
                Cache::delete('__menu__');
                $this->success();
            }
            $this->error();
        }
        return $this->fetch();
    }

    /**
     * 编辑
     * @throws \Exception
     */
    public function edit($ids = null)
    {
        $row = $this->model->find($ids);
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        if (request()->isPost()) {
            //$this->token();
            $params = request()->post("row/a", [], 'strip_tags');
            if ($params) {
                if (!$params['ismenu'] && !$params['pid']) {
                    $this->error(__('The non-menu rule must have parent'));
                }
                if ($params['pid'] != $row['pid']) {
                    $childrenIds = Tree::instance()->init(collection(AuthRule::select())->toArray())->getChildrenIds($row['id']);
                    if (in_array($params['pid'], $childrenIds)) {
                        $this->error(__('Can not change the parent to child'));
                    }
                }
                //这里需要针对name做唯一验证
                $ruleValidate = validate('AuthRule');
                $ruleValidate->rule([
                    'name' => 'require|format|unique:AuthRule,name,' . $row->id,
                ]);
                $result = $row->save($params);//->validate()
                if ($result === false) {
                    $this->error($row->getError());
                }
                $this->success();
            }
            $this->error();
        }
        $this->assign("row", $row);
        return $this->fetch();
    }

    /**
     * 删除
     */
    public function del($ids = "")
    {
        if ($ids) {
            $delIds = [];
            foreach (explode(',', $ids) as $k => $v) {
                $delIds = array_merge($delIds, Tree::instance()->getChildrenIds($v, true));
            }
            $delIds = array_unique($delIds);
            $count = $this->model->where('id', 'in', $delIds)->delete();
            if ($count) {
                Cache::delete('__menu__');
                $this->success();
            }
        }
        $this->error();
    }
}
