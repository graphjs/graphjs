<graphjs-group-settings class={'graphjs-element graphjs-root ' + boxStyle}>
    <div class="graphjs-warning" if={failMessages.length > 0}>
        <ul if={failMessages.length > 0} class="graphjs-fail">
            <li each={failMessage in failMessages}>{failMessage}</li>
        </ul>
    </div>
    <div class="graphjs-content">
        <a ref="uploadWidget" class="graphjs-cover" data-coverphototextlineone={language.coverPhotoLineOne} data-coverphototextlinetwo={language.coverPhotoLineTwo}>
            <img src={group && group.cover ? downsizeImage(group.cover, 320) : 'https://raw.githubusercontent.com/phonetworks/graphjs/master/static/group.png'} />
        </a>
        <form>
            <input ref="title" type="text" placeholder={language.titleInputPlaceholder} value={group ? group.title : ''} />
            <input ref="description" type="text" placeholder={language.descriptionInputPlaceholder} value={group ? group.description : ''} />
            <button ref="submit" onclick={handleInformationSubmit}>{language.submitButton}</button>
        </form>
    </div>
    <script>
        import * as FilePond from 'filepond';
        import language from '../scripts/language.js';
        import getGroup from '../scripts/getGroup.js';
        import setGroupCover from '../scripts/setGroupCover.js';
        import setGroupTitle from '../scripts/setGroupTitle.js';
        import setGroupDescription from '../scripts/setGroupDescription.js';
        import showAlert from '../scripts/showAlert.js';
        import showFileUpload from '../scripts/showFileUpload.js';
        import hideOverlay from '../scripts/hideOverlay.js';
        
        this.language = language('group-settings', opts);
        
        import {downsizeImage} from '../scripts/client.js';
        this.downsizeImage = downsizeImage;

        this.id = opts.id;
        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline' : 'graphjs-box';
        this.failMessages = [];
        this.successMessages = [];

        this.on('before-mount', function() {
            this.handleInformation(opts.id);
        });
        this.on('mount', function() {
            let self = this;
            this.refs.uploadWidget.addEventListener("click", function() {
                FilePond.setOptions({
                    server: {
                        url:window.GraphJSConfig.host,
                        process: {
                            url:'/uploadFile',
                            withCredentials: true,
                            onload:function(result){
                                result = JSON.parse(result);
                                let failMessage = self.language.failMessage;
                                let successMessage = self.language.successMessage;
                                if(result.success) {
                                    setGroupCover(self.id, result.urls[0], function(response) {
                                        if(response.success) {
                                            self.group.cover = result.urls[0];
                                            self.failMessages.includes(failMessage) && self.failMessages.splice(self.failMessages.indexOf(failMessage), 1);
                                            self.successMessages.includes(successMessage) || self.successMessages.push(successMessage);
                                            hideOverlay();
                                            self.update();
                                            if(self.parent && self.parent.tags.hasOwnProperty('graphjs-group-header')) {
                                                self.parent.tags['graphjs-group-header'].updateInformation();
                                            }
                                        } else {
                                            self.successMessages.includes(successMessage) && self.successMessages.splice(self.successMessages.indexOf(successMessage), 1);
                                            self.failMessages.includes(failMessage) || self.failMessages.push(failMessage);
                                            hideOverlay();
                                            self.update();
                                        }
                                    });
                                    self.update();
                                }
                            }
                        }
                    }
                });
                showFileUpload({
                    type:"group-settings",
                    accept:"image/*",
                    maxfilesize:"2MB"
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
            let failMessage = this.language.titleMinLengthError.replace("%s",titleMinimumLengthLimit);
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
            let failMessage = this.language.titleMaxLengthError.replace("%s",titleMaximumLengthLimit);
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
            let failMessage = this.language.descriptionMaxLengthError.replace("%s",descriptionMaximumLengthLimit);
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
                            let failMessage = this.language.titleFailMessage;
                            let successMessage = this.language.titleSuccessMessage;
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
                    let failMessage = this.language.titleFailMessage;
                    let successMessage = this.language.titleSuccessMessage;
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
                            let failMessage = this.language.descriptionFailMessage;
                            let successMessage = this.language.descriptionSuccessMessage;
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
                    let failMessage = this.language.descriptionFailMessage;
                    let successMessage = this.language.descriptionSuccessMessage;
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