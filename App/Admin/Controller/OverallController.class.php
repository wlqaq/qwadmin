<?php

namespace Admin\Controller;
use Admin\Controller\ComController;
class Overallcontroller extends ComController{
    public function reportAll(){
        $weekM = M('week');
        $week = $weekM->select();
        $this->assign('week',$week);
        $users = M('member');
        $user = $users->field('user')->select();
        $this->assign('user', $user);
        $user=$users->getField('user',true);
        $report =M('report');
        $where['user'] = array('in',$user);
        //默认是查看结果
        $reportslist = $report->where('type=1')->limit(200)->field('content,user,id,finsh,comment')->order('date,week desc')->select();
        $this->assign('reportslist',$reportslist);

//        dump($reportslist);die;
        $this->w = 1; //控制选中的周 默认第一周
        $this->jh = 'checked';//控制开关
//        dump($user);die;
        //提交表单返回的结果
        if (IS_POST){
            $this->w = $week;
            $data = I('post.');
            $year = $data['year1'].'-'.$data['year2'];//学年
            $week = $data['week'];
            if (isset($data['type'])){
                //结果
                $reportslist = $report->where('type=1 and year=\''.$year. '\' and week='.$week.'')->field('content,user,id,finsh,comment')->order('week desc')->select();
                $this->jh = 'checked';

            }else{
                //计划
                $reportslist = $report->where('type=0 and year=\''.$year.' \'and week='.$week.'')->field('content,user,id,finsh,comment')->order('week desc')->select();
                $this->jh = '';

            }
            //dump($data);die;
            $this->assign('reportslist',$reportslist);
        }
        $this->display('Overall/index');
        //dump($reports);die;
    }
    public function fwork(){
        $fwork = M('fwork');
        $weektype = M('fwork_weektype');
        $weektypes= $weektype->select();
        $fworks = $fwork->select();
       // dump($fworks);die;
        $this->assign([
            'fworks'=>$fworks,
            'weektypes'=>$weektypes
            ]);
        if (IS_POST){
            $weektypeid = I('post.weektype');

            $resall = $weektype->where("status != 0")->setField('status','0');
            $res = $weektype->where("id = ".$weektypeid)->setField('status','1');;

            if ($resall || $res){
                $this->success('发放成功');
            }

        }else{
            $this->display();
        }

    }
    public function editfwork(){
        $id = isset($_REQUEST['id']) ? $_REQUEST['id'] : false;
        $fwork = M('fwork');

        $update = $fwork->where('id ='.$id)->find();
        $this->assign('update',$update);
        if (IS_POST){
            $data = I('post.');
            $res = $fwork->where("id =".$id)->save($data);
            if ($res){
                $this->success('修改成功');
            }
        }else{
            $this->display();
        }




    }
    public function addwork(){
        if (IS_POST){
            $data = I('post.');
            $fwork = M('fwork');
            $res = $fwork->add($data);
            if ($res){
                $this->success('添加成功');
            }

        }else{
            $this->display();
        }

    }
    public function delfwork(){
        $id = isset($_REQUEST['id']) ? $_REQUEST['id'] : false;
        if ($id){
            $fwork = M('fwork');
            $fwork = $fwork->where('id='.$id)->delete();
            if ($fwork){
                $this->success("删除成功",U('fwork'));
            }
        }else{
            $this->display();
        }



    }


}