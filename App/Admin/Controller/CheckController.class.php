<?php
/**
 *
 * 
 *
 **/

namespace Admin\Controller;
//use Vendor\PHPExcel;
use Admin\Controller\ComController;

use Admin\Model\Nanyang ;
use http\Env\Request;

class CheckController extends ComController
{


    //工作检查
    public function jcqrb(){
        $weektype = M('fwork_weektype');
        $fwork = M('fwork');
        $fworks = $fwork->select();
        //dump($fworks);die;
        $weektype = $weektype->where('status = 1')->find();
        $weektype  = $weektype['weektype'];
        $room = M('room');
        $room = $room->field('rid,room')->order('room')->select();
        $this->assign([
            'room'=>$room,
            'weektype'=>$weektype,
            'fworks'=>$fworks
        ]);
        $this->display();
    }
    //工作报告
    public function gongzuobaogao(){

        $weekM = M('week');
        $week = $weekM->select();
        $this->assign('week',$week);
        if (IS_POST){
            $report = M('report');
            $data = I('post.');

            //提交多条数据
            //收集type为0的非空字段 0为计划

            for($i=0;$i<count($data['content']);$i++){
                if($data['content'][$i]!=""){
                    $dataList[] = array(
                        //array('表字段'=>'值')
                        'content'=>$data['content'][$i],
                        'comment'=>$data['comment'][$i],
                        'finsh'=>$data['finsh'][$i],
                        'type'=>'0',
                        'week'=>$data['week'],
                        'year'=>$data['year'],
                        'user' =>$data['user']
                    );
                }




            }
            //收集type为1的非空字段 1为总结
            for($i=0;$i<count($data['zjcontent']);$i++){
                if($data['zjcontent'][$i]!="") {
                    $zjList[] = array(
                        //array('表字段'=>'值')
                        'content' => $data['zjcontent'][$i],
                        'comment' => $data['zjcomment'][$i],
                        'finsh' => $data['zjfinsh'][$i],
                        'type' => '1',
                        'week' => $data['zjweek'],
                        'year' => $data['zjyear'],
                        'user' => $data['user']
                    );
                }

            }
            $res = $report->addAll($dataList);//批量插入为0的数据
            $zjres = $report->addAll($zjList);//批量插入为1的数据

            if ($res || $zjres){
                $this->success('提交成功');
            }else{
                $this->error('提交失败');
            }



        }


        $this->display('Check/gongzuobaogao');
    }

    public function index(){
        $room = M('room');
        $week = M('week');
        $week = $week->field('id,name')->select();
        $room = $room->field('rid,room')->order('room')->select();
        $this->assign('room',$room);
        $this->assign('week',$week);
        $this->display();
    }
    //南博仓库
    public function Xunc(){
		if(!empty($_POST)){
			 $list->create();
			 $c= $list-> Xunc();
			 if($c){
				 $this->success("上传日志成功",U('Check/index'));
			 }
			 else{
				 $this ->error("上传日志失败,请重新填写",U('Check/index'));
			 }
		 } else{
			 $this->display('Check/index');
		 }
    }
    public function collect(){
        $user =  $member = M('member')->where('uid=' . $this->USER['uid'])->getField('user');
        $reportslist = M('report')->where("user='".$user."'")->select();
        $weekM = M('week');
        $week = $weekM->select();
        $this->assign('week',$week);
        $users = M('member');

        $this->assign('user',$user);

        $report =M('report');




        $this->assign([
            'reportlist'=> $reportslist,
            'w'=>1,//控制选中的周 默认第一周
            'jh'=>'checked',//控制开关 总结/计划
            ]);

        //提交表单返回的结果
        if (IS_POST){

            $data = I('post.');
            $this->w = $data['week'];
            $year = $data['year1'].'-'.$data['year2'];//学年
            $week = $data['week'];
            if (isset($data['type'])){
                //结果
                $reportslist = $report->where('type=1 and year=\''.$year. '\' and week='.$week.'')->field('content,user,id,finsh,comment')->order('week desc')->select();
                $this->jh = 'checked'; //控制选中的开关

            }else{
                //计划
                $reportslist = $report->where('type=0 and year=\''.$year.' \'and week='.$week.'')->field('content,user,id,finsh,comment')->order('week desc')->select();
                $this->jh = '';  //控制选中的开关

            }
            //dump($data);die;
            $this->assign('reportslist',$reportslist);
        }
        $this->display('Check/collect');
        //dump($reports);die;



    }

		
}
	
