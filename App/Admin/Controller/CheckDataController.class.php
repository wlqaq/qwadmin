<?php


namespace Admin\Controller;
use Admin\Controller\ComController;

//处理日常数据类控制器
class CheckDataController extends ComController
{
    //工作检查
    public function jcqrb(){

        if (IS_POST){
            $data = I("post.");
          //dump($data);die();

            for($i=0;$i<count($data['content']);$i++){
                if ($data['language'][$i]=="完成"){
                    $dataList[] = array(
                        'term'=>$data['term'],
                        'year'=>$data['year1'].'-'.$data['year2'],
                        'weekname'=>$data['weekname'],
                        'room'=>$data['room'],
                        'content'=>$data['content'][$i],
                        'requirement'=>$data['requirement'][$i],
                        'type'=>$data['language'][$i],
                        'beizhu'=>"完成",
                        'user'=>$data['user'],
                        'shijian'=>$data['shijian']
                    );
                }else{
                    $dataList[] = array(
                        'term'=>$data['term'],
                        'year'=>$data['year1'].'-'.$data['year2'],
                        'weekname'=>$data['weekname'],
                        'room'=>$data['room'],
                        'content'=>$data['content'][$i],
                        'requirement'=>$data['requirement'][$i],
                        'type'=>$data['language'][$i],
                        'beizhu'=>$data['beizhu'][$i],
                        'user'=>$data['user'],
                        'shijian'=>$data['shijian']
                    );
                }

            }
            //dump($dataList);die();
            $checkword = M('checkword');
            $res = $checkword->addAll($dataList);
            if ($res){
                $this->success("提交成功");
            }else{
                $this->error("提交失败");
            }


        }
        $this->display();
    }
    //工作报告
    public function gongzuobaogao()
    {

        $weekM = M('week');
        $week = $weekM->select();
        $this->assign('week', $week);
        if (IS_POST) {
            $report = M('report');
            $data = I('post.');

            //提交多条数据
            //收集type为0的非空字段 0为计划

            for ($i = 0; $i < count($data['content']); $i++) {
                if ($data['content'][$i] != "") {
                    $dataList[] = array(
                        //array('表字段'=>'值')
                        'content' => $data['content'][$i],
                        'comment' => $data['comment'][$i],
                        'finsh' => $data['finsh'][$i],
                        'type' => '0',
                        'week' => $data['week'],
                        'year' => $data['year1'].'-'.$data['year2'],
                        'user' => $data['user'],
                        'term' =>$data['term']
                    );
                }


            }
            //收集type为1的非空字段 1为总结
            for ($i = 0; $i < count($data['zjcontent']); $i++) {
                if ($data['zjcontent'][$i] != "") {
                    $zjList[] = array(
                        //array('表字段'=>'值')
                        'content' => $data['zjcontent'][$i],
                        'comment' => $data['zjcomment'][$i],
                        'finsh' => $data['zjfinsh'][$i],
                        'type' => '1',
                        'week' => $data['zjweek'],
                        'year' => $data['zjyear'],
                        'user' => $data['user'],
                        'year' => $data['zjyear1'].'-'.$data['zjyear2'],
                        'term' =>$data['zjterm']
                    );
                }

            }
            $res = $report->addAll($dataList);//批量插入为0的数据
            $zjres = $report->addAll($zjList);//批量插入为1的数据

            if ($res || $zjres) {
                $this->success('提交成功');
            } else {
                $this->error('提交失败');
            }


        }
    }
    public function xunch(){
       // dump($_FILES['ethumb']);die;


        if (IS_POST){

            $data = I('post.');
            //照片解码上传
            for ($i = 0;$i<count($data['base']);$i++){
                $img = base64_decode($data['base'][$i]);
                $imageName = $data['room']."_".date("His",time())."_".rand(1111,9999).'.png';
                //判断是否有逗号 如果有就截取后半部分
                //$image = explode(',',$img);
                //设置图片保存路径
                $path = "/Public/ethumb/".$data['room']."/".date("Ymd",time());
                $rootpath = $_SERVER["DOCUMENT_ROOT"].$path;
                //dump($path);die;
                //判断目录是否存在 不存在就创建
                if (!is_dir($rootpath)){
                    mkdir($rootpath,0777,true);
                }
                //图片路径
                $imageSrc= $rootpath."/". $imageName;
                file_put_contents($imageSrc, $img);//返回的是字节数
                $data['ethumb'][$i] = $path;

            }



            for($i=0;$i<count($data['section']);$i++){
                //时间段
                $subtime = $data['section'][$i]<= 3?'早上':($data['section'][$i]<=5?'中午':'晚上');
                //其他事宜
                $other=$data['section'][$i]<= 3?$data['other'][0]:($data['section'][$i]<=5?$data['other'][1]:$data['other'][2]);
                //设备情况的三种类型

                if ($data['equipment'][$i] == 1){
                    //正常
                    $datalist[] = array(
                        'equipment' => $data['equipment'][$i],
                        'section'=>$data['section'][$i],
                        'date'=> date(),
                        'subtime'=> $subtime,
                        'user'=>$data['user'],
                        'year'=>$data['year1'].'-'.$data['year2'],
                        'term'=>$data['term'],
                        'day'=>$data['workday'],
                        'error' =>'正常',
                        'room'=>$data['room'],
                        'other' => $other,
                        'ethumb'=>implode(';',$data['ethumb'])
                    );
                }elseif ($data['equipment'][$i] == 2){
                    //异常
                    $datalist[] = array(
                        'workday'=>$data['workday'],
                        'equipment' => $data['equipment'][$i],
                        'section'=>$data['section'][$i],
                        'date'=> date(),
                        'subtime'=>  $subtime,
                        'day'=>$data['workday'],
                        'user'=>$data['user'],
                        'year'=>$data['year1'].'-'.$data['year2'],
                        'term'=>$data['term'],
                        'error' =>$data['error'][$i],
                        'room'=>$data['room'],
                        'other' => $other,
                        'ethumb'=>implode(';',$data['ethumb'])
                    );
                }else{
//                    //没课
                    $datalist[] = array(
                        'equipment' => $data['equipment'][$i],
                        'section'=>$data['section'][$i],
                        'date'=> date(),
                        'subtime'=>  $subtime,
                        'user'=>$data['user'],
                        'day'=>$data['workday'],
                        'year'=>$data['year1'].'-'.$data['year2'],
                        'term'=>$data['term'],
                        'error' =>$data['error'][$i],
                        'room'=>$data['room'],
                        'other' => $other,
                        'ethumb'=>implode(';',$data['ethumb'])

                    );
                }
            }
            $xunch =  M('xunch');
            $res = $xunch->addAll($datalist);


           if($res){
               $this->success('添加成功');
            }else{
               $this->error('提交失败');
           }
        }
    }
}