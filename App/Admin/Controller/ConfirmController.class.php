<?php
/**
 *
 * 
 *
 **/

namespace Admin\Controller;

use Admin\Controller\ComController;
use Admin\Model\Nanyang ;

class ConfirmController extends ComController
{
    public function quereng_add(){	
    
		if(!empty($_POST)){
			
			 $list->create();
			 $q= $list-> quereng_add();
			 if($q){
				 $this->success("上传日志成功",U('Confirm/index'));
			 }
			 else{
				 $this ->error("上传日志失败,请重新填写",U('Confirm/index'));
			 }
		 } else{
			 $this->display('index');
		 }     
		}
	
		
    }
	
