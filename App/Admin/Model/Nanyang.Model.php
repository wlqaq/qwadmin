<?php
namespace app\admin\model;

use think\Model;

class Check extends Model
{
	public function AllChecklog(){
			$log_list= M ('qw_Check');
			$list= $log_list->select();
			$this->assign('list',$list);
			$this->display('Check');
	}
	     
}
