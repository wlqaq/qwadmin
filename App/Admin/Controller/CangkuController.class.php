<?php
/**
 *
 * 
 *
 **/

namespace Admin\Controller;

use Admin\Controller\ComController;
use Admin\Model\Nanyang ;

class CangkuController extends ComController
{	
    public function cangku(){	
    
		if(!empty($_POST)){
			
			 $list->create();
			 $c= $list-> xunc();
			 if($c){
				 $this->success("上传日志成功",U('Cangku/index'));
			 }
			 else{
				 $this ->error("上传日志失败,请重新填写",U('Cangku/index'));
			 }
		 } else{
			 $this->display('Cangku/index');
		 }     
		}
    
}