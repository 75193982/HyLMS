/**
 * 插行和删行 2016.6.22 ww 表格必须字段 orderNo、mark、itemName、spec、unit、vendor、drugid。
 * 
 */
//序号
function getrow(mytable)
{
	var rows = $('#' + mytable).datagrid('getRows');
	//alert(JSON.stringify(rows));
	for(var i = 0;i<rows.length;i++)
	{
		rows[i].orderNo = i+1;
	}
	//alert(JSON.stringify(rows));
	$('#' + mytable).datagrid('loadData',{"total" : rows.length,"rows" : rows});
}
//插行
function addrow(mytable) {
	var selectRowIndex = $('#' + mytable).datagrid('getRowIndex',
			$('#' + mytable).datagrid('getSelected'));
	if (selectRowIndex === 0 || selectRowIndex > 0) {
		$('#' + mytable).datagrid('insertRow', {
			index : selectRowIndex,
			row : {
				mark : '',//标记不为空
				itemName : '',
				spec : '',
				unit : '',
				vendor : '',
				drugid : ''
			}
		});
		getrow(mytable);
	} else {
		if ($('#' + mytable).datagrid('getRows') == null
				|| $('#' + mytable).datagrid('getRows') == "") {
			$('#' + mytable).datagrid('insertRow', {
				index : 0,
				row : {
					mark : 'Y',//标记不为空
					itemName : '',
					spec : '',
					unit : '',
					vendor : '',
					drugid : ''
				}
			});
			getrow(mytable);
		} else {
			$.messager.alert('提示:', "请先选择一行!", 'info');
		}
	}
}
/**
 * 删行
 */
function deleterow(mytable,sum1,sum2,total1,total2)
{
	var selectRowIndex = $('#' + mytable).datagrid('getRowIndex',$('#' + mytable).datagrid('getSelected'));
	if(selectRowIndex === 0 || selectRowIndex >0)
	{
		$('#' + mytable).datagrid('deleteRow',selectRowIndex);
		getrow(mytable);
		getSum(mytable,sum1,sum2,total1,total2);
	}
	else
	{
		$.messager.alert('提示:',"请先选择一行!",'info');
	}
}
/**
 * 计算总和金额     total1、total2为表格的字段id，sum1、sum2为页头上的两个金额总和id
 */        
function getSum(mytable,sum1,sum2,total1,total2)
{
	var v1 = 0;
	var v2 = 0;
	var rows = $('#' + mytable).datagrid('getRows');
	for(var i = 0;i<rows.length;i++)
	{
		if(rows[i][total1] != "" && rows[i][total1] != null)
		{
			v1 += parseFloat(rows[i][total1]);
		}
		if(rows[i][total2] != "" && rows[i][total2] != null)
		{
			v2 += parseFloat(rows[i][total2]);
		}
	}
	if(v1 != 0 && v1 != "")
	{
		$('#'+sum1).numberbox('setValue', v1);
	}
	else
	{
		$('#'+sum1).numberbox('setValue', '');
	}
	if(v2 != 0 && v2 != "")
	{
		$('#'+sum2).numberbox('setValue', v2);
	}
	else
	{
		$('#'+sum2).numberbox('setValue', '');
	}
}