<docs-index>
    <aside>
        <docs-menu callback={changeProperties} components={components} functions={functions}></docs-menu>
    </aside>
    <main ref="main">
    </main>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        docs-index {
            display: inline-block;
            width: 100%;
            aside {
                overflow-y: scroll;
                position: fixed;
                z-index: 9;
                top: 0;
                bottom: 0;
                left: 0;
                width: 20%;
                height: auto;
                background: linear-gradient(rgb(93, 60, 246), rgb(158, 119, 255));
                .menu {
                    color: white;
                    display: inline-block;
                    padding: 10%;
                    img {
                        width: 85%;
                        height: auto;
                        margin: 7.5%;
                    }
                    form {
                        fieldset {
                            border: none;
                            input[type="radio"] {
                                display: inline-block;
                                width: auto;
                                margin-left: 10%;
                                &:first-of-type {
                                    margin-left: 0;
                                }
                            }
                        }
                    }
                    h2 {
                        color: white;
                        display: inline-block;
                        width: 100%;
                        margin: 1em 0;
                        padding: 0 5%;
                    }
                    a {
                        color: white;
                        font-size: 1.1em;
                        line-height: 200%;
                        display: inline-block;
                        width: 100%;
                        padding: 0 5%;
                        &.active {
                            color: yellow;
                        }
                        &.submenu {
                            display: none;
                            font-size: 1em;
                            line-height: 150%;
                            &::before {
                                content: "└";
                                margin-right: .25em;
                            }
                            &.visible {
                                display: block;
                            }
                        }
                    }
                }
            }
            main {
                display: inline-block;
                width: 70%;
                margin: 2.5% 5% 2.5% 25%;
                h1 {
                    color: rgb(93, 60, 246);
                    margin: 1em 0;
                }
                h2 {
                    color: rgb(158, 119, 255);
                    margin: 2em 0;
                }
                .demo {
                    width: 100%;
                    margin-bottom: 5%;
                    & > * {
                        margin: 0;
                    }
                }
                .options {
                    form {
                        width: 100%;
                        margin-bottom: 5%;
                        margin-right: 5%;
                        fieldset {
                            float: left;
                            position: relative;
                            width: 47.5%;
                            height: 5em;
                            margin: 0;
                            margin-bottom: 2.5%;
                            .no-padding;
                            border: none;
                            &:nth-child(even) {
                                margin-left: 5%;
                            }
                            legend {
                                float: left;
                                width: auto;
                                text-align: left;
                            }
                            input[type="checkbox"] {
                                display: inline-block;
                                max-width: 1.5em;
                                max-height: 1.5em;
                                margin: 0;
                            }
                            input[type="text"] {
                                position: relative;
                                margin: 0;
                                margin-top: .5em;
                            }
                            .radiobutton {
                                display: inline-block;
                                width: 100%;
                                height: 2.5em;
                                margin-top: .5em;
                            }
                            input[type="radio"] {
                                display: inline-block;
                                float: left;
                                height: inherit;
                                max-width: 1.5em;
                                margin: 0;
                                .no-padding;
                                & + label {
                                    float: left;
                                    height: inherit;
                                    line-height: 2.5em;
                                    margin-right: 2.5%;
                                }
                            }
                        }
                        .code {
                            display: block;
                            overflow: hidden;
                            width: 100%;
                            font-size: 1.2em;
                            line-height: 150%;
                            word-wrap: break-word;
                            white-space: pre-wrap;
                        }
                        button {
                            .background-color-states(rgb(158, 119, 255));
                        }
                    }
                }
            }
        }
    </style>
    <script>
        import './menu.tag';
        // Functions
        import showGroupCreator from '../scripts/showGroupCreator.js';
        this.functionsList = {
            showGroupCreator: showGroupCreator
        };
        this.functions = [
            {"label": "Create Group", "function": "showGroupCreator"}
        ];
        //Components
        this.components = [
            {"label": "State", "component": "state"},
            {"label": "Auth", "component": "auth"},
            {"label": "Register", "component": "auth-register", "parent": "auth"},
            {"label": "Login", "component": "auth-login", "parent": "auth"},
            {"label": "Reset Password", "component": "auth-reset", "parent": "auth"},
            {"label": "Comments", "component": "comments"},
            {"label": "Messages", "component": "messages"},
            {"label": "Forum", "component": "forum"},
            {"label": "List", "component": "forum-list", "parent": "forum"},
            {"label": "Thread", "component": "forum-thread", "parent": "forum"},
            {"label": "Compose", "component": "forum-compose", "parent": "forum"},
            {"label": "Star: Button", "component": "star-button"},
            {"label": "Star: List", "component": "star-list"},
            {"label": "Profile", "component": "profile"},
            {"label": "Profile: Card", "component": "profile-card"},
            {"label": "Group", "component": "group"},
            {"label": "Group: Card", "component": "group-card"},
            {"label": "Wallet", "component": "wallet"},
            {"label": "Alert", "component": "alert"}
        ];
        this.activeItem = 'introduction';
        this.changeProperties = (event) => {
            for(let element of event.currentTarget.parentNode.children) {
                element.classList.remove('active');
            }
            event.currentTarget.classList.add('active');
            if(!event.currentTarget.dataset.hasOwnProperty('parent')) {
                let removals = document.querySelectorAll('.submenu');
                for(let removal of removals) {
                    removal.classList.remove('visible');
                }
                let parent = event.currentTarget.dataset.component;
                let query = '.' + parent + '-item';
                for(let item of document.querySelectorAll(query)) {
                    item.classList.add('visible');
                }
            }
            this.activeItem = event.target.dataset.id;
            this.update();
            this.refs.main.innerHTML = '';
            if(event.currentTarget.dataset.type == 'component') {
                this.createTag(event.currentTarget.dataset.component, event.currentTarget.dataset.label);
            } else if(event.currentTarget.dataset.type == 'function') {
                let functionName = event.currentTarget.dataset.function;
                this.functionsList[functionName]();
            }
        }
        this.createTag = (itemComponent, itemLabel) => {
            let currentElement = document.createElement('docs-' + itemComponent);
            let component = document.createAttribute('component');
            component.value = 'graphjs-' + itemComponent;
            currentElement.setAttributeNode(component);
            let label = document.createAttribute('label');
            label.value = itemLabel;
            currentElement.setAttributeNode(label);
            riot.mount(currentElement);
            this.refs.main.appendChild(currentElement);
        }
    </script>
</docs-index>