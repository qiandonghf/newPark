function getInfo(type){
	var info = {};
	switch(type){
	case "south":
		info = {
			'name':'江南基地',
			'telephone':'0571-87021787',
			'qq':'904620427',
			'email':'904620427@qq.com',
			'fax':'0571-87020197',
			'address':'杭州市滨江区伟业路1号高新软件园9号楼402'
		}
		break;
	case "north":
		info = {
			'name':'江北基地',
			'telephone':'0571-88218871',
			'qq':'929242884',
			'email':'929242884@qq.com',
			'fax':'0571-88073859',
			'address':'杭州市文三路199号创业大厦六楼'
		}
		break;
	}
	return info;
}