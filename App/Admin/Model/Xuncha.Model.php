<?php
namespace app\index\model;

use think\Model;

class Xuncha extends Model
{
	public function All(){
			$log_list= M ('Xuncha');
			$list= $log_list->select();
			$this->assign('list',$list);
			$this->display('xuncha');
	}
	     
}
