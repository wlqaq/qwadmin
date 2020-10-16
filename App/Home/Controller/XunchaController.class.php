<?php
/**
 *
 * 版权所有：恰维网络<qwadmin.qiawei.com>
 * 作    者：寒川<hanchuan@qiawei.com>
 * 日    期：2016-01-21
 * 版    本：1.0.0
 * 功能说明：前台控制器演示。
 *
 **/
namespace Home\Controller;

use Vendor\Page;

class XunchaController extends ComController
{
    public function add()
    {
	$list= D('Xuncha');
		 if(!empty($_POST)){
			/*  $list->week =$_POST['week'];
			 $list->days =$_POST['days'];
			 $list->people =$_POST['people'];
			 $list->classes =$_POST['classes'];
			 $list->equioment =$_POST['equioment'];
			 $list->log =$_POST['log'];
			 $list->other =$_POST['other']; */
			 $list->create();
			 $c= $list-> add();
			 if($c){
				 $this->success("上传日志成功"，U('index/index'))
			 }else{
				 $this ->error("上传日志失败"，U('index/index'))
			 }
		 } else{
			 $this->display('index');
		 }     
       
    }
    
}