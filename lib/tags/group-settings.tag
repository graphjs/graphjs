<graphjs-group-settings class="graphjs-element graphjs-root graphjs-box">
    <div class="graphjs-warning" if={failMessages.length > 0}>
        <ul if={failMessages.length > 0} class="graphjs-fail">
            <li each={failMessage in failMessages}>{failMessage}</li>
        </ul>
    </div>
    <div class="graphjs-content">
        <a ref="uploadWidget" class="graphjs-cover">
            <img src={group && group.cover ? downsizeImage(group.cover, 320) : 'https://res.cloudinary.com/graphjs/image/upload/graphjs/content/covers/group.png'} />
        </a>
        <form>
            <input ref="title" type="text" placeholder={i18n.titleInputPlaceholder} value={group ? group.title : ''} />
            <input ref="description" type="text" placeholder={i18n.descriptionInputPlaceholder} value={group ? group.description : ''} />
            <button ref="submit" onclick={handleInformationSubmit}>{i18n.submitButtonText}</button>
        </form>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/group-settings.less';
    </style>
    <script>
        import getGroup from '../scripts/getGroup.js';
        import setGroupCover from '../scripts/setGroupCover.js';
        import setGroupTitle from '../scripts/setGroupTitle.js';
        import setGroupDescription from '../scripts/setGroupDescription.js';
        import showAlert from '../scripts/showAlert.js';
        import '../vendor/cloudinary/upload-widget.js';

        import internationalization from '../i18n';
        let i18n = internationalization[window.GraphJSConfig.language]['group-settings'];
        i18n = {...i18n,...JSON.parse(JSON.stringify(opts))}
        this.i18n = i18n;
        
        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.id = opts.id;
        this.failMessages = [];
        this.successMessages = [];

        this.on('before-mount', function() {
            this.handleInformation(opts.id);
        });
        this.on('mount', function() {
            let self = this;
            this.refs.uploadWidget.addEventListener("click", function() {
                cloudinary.openUploadWidget({
                    cloud_name: 'graphjs',
                    upload_preset: 't8vl6sxm',
                    multiple: false,
                    cropping: 'server',
                    cropping_aspect_ratio: 16 / 9,
                    cropping_coordinates_mode: 'custom',
                    theme: 'minimal'
                },
                function(error, result) {
                    let failMessage = i18n.failMessage;
                    let successMessage = i18n.successMessage;
                    if(result) {
                        setGroupCover(self.id, result[0].url, function(response) {
                            if(response.success) {
                                self.group.cover = result[0].url;
                                self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                                self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                                self.update();
                                if(self.parent && self.parent.tags.hasOwnProperty('graphjs-group-header')) {
                                    self.parent.tags['graphjs-group-header'].updateInformation();
                                }
                            } else {
                                self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                                self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                                self.update();
                            }
                        });
                        self.update();
                    }
                    if(error) {
                        self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                        self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                        self.update();
                    }
                });
            }, false);
        });

        this.handleInformation = (id) => {
            let self = this;
            getGroup(id, function(response) {
                if(response.success) {
                    self.group = response.group;
                    self.update();
                } else {
                    //Handle errors
                }
            });
        }
        this.checkTitleMinimumLength = () => {
            let titleMinimumLengthLimit = 2;
            let failMessage = i18n.titleMinLengthError.replace("%s",titleMinimumLengthLimit);
            if(this.refs.title.value.length >= titleMinimumLengthLimit) {
                this.refs.title.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.title.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkTitleMaximumLength = () => {
            let titleMaximumLengthLimit = 80;
            let failMessage = i18n.titleMaxLengthError.replace("%s",titleMaximumLengthLimit);
            if(this.refs.title.value.length <= titleMaximumLengthLimit) {
                this.refs.title.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.title.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.checkDescriptionMaximumLength = () => {
            let descriptionMaximumLengthLimit = 255;
            let failMessage = i18n.descriptionMaxLengthError.replace("%s",descriptionMaximumLengthLimit);
            if(this.refs.description.value.length <= descriptionMaximumLengthLimit) {
                this.refs.description.classList.remove('graphjs-error');
                this.failMessages.includes(failMessage) && this.failMessages.splice(this.failMessages.indexOf(failMessage), 1);
                return true;
            } else {
                this.refs.description.classList.add('graphjs-error');
                this.failMessages.includes(failMessage) || this.failMessages.push(failMessage);
                return false;
            }
        }
        this.validateInformation = () => {
            let validTitleMinimumLength = this.checkTitleMinimumLength();
            let validTitleMaximumLength = this.checkTitleMaximumLength();
            let validDescriptionMaximumLength = this.checkDescriptionMaximumLength();
            if(
                validTitleMinimumLength && validTitleMaximumLength && // Title
                validDescriptionMaximumLength // Description
            ) {
                return true;
            } else {
                this.refs.submit.classList.remove('graphjs-loading');
                return false;
            }
        }
        this.handleInformationSubmit = (event) => {
            event.preventDefault();
            let self = this;
            self.refs.submit.classList.remove('graphjs-loading');
            let title = self.refs.title.value;
            let description = self.refs.description.value;
            self.refs.title.className = '';
            self.refs.description.className = '';
            self.failMessages = [];
            self.successMessages = [];
        	if(self.validateInformation()) {
                if(title != self.group.title) {
                    setGroupTitle(
                        self.id,
                        title,
                        function(response) {
                            let failMessage = i18n.titleFailMessage;
                            let successMessage = i18n.titleSuccessMessage;
                            if(response.success) {
                                self.group.title = title;
                                self.refs.title.classList.remove('graphjs-error');
                                self.refs.title.classList.add('graphjs-success');
                                self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                                self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                                self.refs.submitPassword.classList.remove('graphjs-loading');
                                self.update();
                                if(self.parent && self.parent.tags.hasOwnProperty('graphjs-group-header')) {
                                    self.parent.tags['graphjs-group-header'].updateInformation();
                                }
                            } else {
                                self.refs.title.classList.remove('graphjs-success');
                                self.refs.title.classList.add('graphjs-error');
                                self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                                self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                                self.refs.submitPassword.classList.remove('loading');
                                self.update();
                            }
                        }
                    );
                } else {
                    let failMessage = i18n.titleFailMessage;
                    let successMessage = i18n.titleSuccessMessage;
                    self.refs.title.classList.remove('graphjs-error');
                    self.refs.title.classList.add('graphjs-success');
                    self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                    self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                    self.refs.submitPassword.classList.remove('graphjs-loading');
                    self.update();
                }
                if(description != self.group.description) {
                    setGroupDescription(
                        self.id,
                        description,
                        function(response) {
                            let failMessage = i18n.descriptionFailMessage;
                            let successMessage = i18n.descriptionSuccessMessage;
                            if(response.success) {
                                self.group.description = description;
                                self.refs.description.classList.remove('graphjs-error');
                                self.refs.description.classList.add('graphjs-success');
                                self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                                self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                                self.refs.submitPassword.classList.remove('graphjs-loading');
                                self.update();
                                if(self.parent && self.parent.tags.hasOwnProperty('graphjs-group-header')) {
                                    self.parent.tags['graphjs-group-header'].updateInformation();
                                }
                            } else {
                                self.refs.description.classList.remove('graphjs-success');
                                self.refs.description.classList.add('graphjs-error');
                                self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                                self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                                self.refs.submitPassword.classList.remove('graphjs-loading');
                                self.update();
                            }
                        }
                    );
                } else {
                    let failMessage = i18n.descriptionFailMessage;
                    let successMessage = i18n.descriptionSuccessMessage;
                    self.refs.description.classList.remove('graphjs-error');
                    self.refs.description.classList.add('graphjs-success');
                    self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                    self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                    self.refs.submitPassword.classList.remove('graphjs-loading');
                    self.update();
                }
            }
        }
    </script>
</graphjs-group-settings>