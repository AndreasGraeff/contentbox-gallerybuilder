/* interceptor gallery */
component extends="modules.contentbox-admin.interceptors.CBRequest"
{

	void function configure(){}

	void function preProcess(event,struct interceptData) eventPattern="^contentbox-gallerybuilder"{
		super.preProcess(event,interceptData);
	}

}