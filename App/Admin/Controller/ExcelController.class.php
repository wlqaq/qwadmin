<?php
/**
 *
 * 版权所有：恰维网络<qwadmin.qiawei.com>
 * 作    者：寒川<hanchuan@qiawei.com>
 * 日    期：2016-09-20
 * 版    本：1.0.0
 * 功能说明：后台首页控制器。
 *
 **/

namespace Admin\Controller;

use Admin\Controller\ComController;

class ExcelController extends ComController
{
    public function exportExcel($expTitle,$expCellName,$expTableData){
        $xlsTitle = iconv('utf-8', 'gb2312', $expTitle);//文件名称
        $fileName = $expTitle.date('_Ymd_His');//or $xlsTitle 文件名称可根据自己情况设定
        $cellNum = count($expCellName);
        $dataNum = count($expTableData);
        vendor("PHPExcelUnit.PHPExcel");
        $objPHPExcel = new \PHPExcel();
        $cellName = array('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','AA','AB','AC','AD','AE','AF','AG','AH','AI','AJ','AK','AL','AM','AN','AO','AP','AQ','AR','AS','AT','AU','AV','AW','AX','AY','AZ');
        $objPHPExcel->getActiveSheet(0)->mergeCells('A1:'.$cellName[$cellNum-1].'1');//合并单元格
        $objPHPExcel->setActiveSheetIndex(0)->setCellValue('A1', $expTitle.'  Export time:'.date('Y-m-d H:i:s'));//第一行标题
        for($i=0;$i<$cellNum;$i++){
            $objPHPExcel->setActiveSheetIndex(0)->setCellValue($cellName[$i].'2', $expCellName[$i][1]);
        }
        // Miscellaneous glyphs, UTF-8
        for($i=0;$i<$dataNum;$i++){
            for($j=0;$j<$cellNum;$j++){
                $objPHPExcel->getActiveSheet(0)->setCellValue($cellName[$j].($i+3), $expTableData[$i][$expCellName[$j][0]]);
            }
        }
        header('pragma:public');
        header('Content-type:application/vnd.ms-excel;charset=utf-8;name="'.$xlsTitle.'.xls"');
        header("Content-Disposition:attachment;filename=$fileName.xls");//attachment新窗口打印inline本窗口打印
        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        $objWriter->save('php://output');
        exit;
    }
    function expUser($xlsName='', $xlsCell=array(), $xlsModel=''){//导出Excel
        $xlsName  = "User用户数据表";
        $xlsCell  = array(
            array('uid','账号序列'),
            array('user','名字'),
            array('phone','手机号'),
            array('qq','qq'),
            array('email','email'),
        );
        $xlsModel = M('Member');
        $xlsData  = $xlsModel->Field('uid,user,phone,qq,email')->select();

        $this->exportExcel($xlsName,$xlsCell,$xlsData);
    }
    //导出工作总结
    function expReport($xlsName='', $xlsCell=array(), $xlsModel=''){//导出Excel

        if (IS_POST){
            $xlsCell  = array(
                array('id','账号序列'),
                array('user','管理员'),
                array('content','内容'),
                array('finsh','拟完成时间'),
                array('comment','备注'),
                array('type','类型'),
            );
            $report = M('report');
            $data = I('post.');
            $zjweek = $data['week']; //总结总
            $jhweek = $zjweek+1;  //计划周
            $xlsName  = "第".$zjweek."工作总结".$jhweek."计划"; //表格头部
            $xlsData = $report->where('week='.$zjweek.' or week='.$jhweek)->field('type,id,user,content,finsh,comment')->select();
            for ($i = 0;$i<count($xlsData);$i++){
                $xlsData[$i]['type']  = $xlsData[$i]['type'] == 0?'计划':'总结';
                $xlsData[$i]['id'] = '=row()-2'; //单元格序号
            }
            $this->exportExcel($xlsName,$xlsCell,$xlsData);

        }


//        $xlsModel = M('Member');
//        $xlsData  = $xlsModel->Field('uid,user,phone,qq,email')->select();


    }


}