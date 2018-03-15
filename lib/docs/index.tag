<docs-index>
    <aside>
        <docs-menu callback={changeActiveItem} items={items}></docs-menu>
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
                        display: inline-block;
                        width: 100%;
                        padding: 5%;
                        &.active {
                            color: yellow;
                        }
                    }
                }
            }
            main {
                display: inline-block;
                width: 70%;
                margin: 2.5% 5% 2.5% 25%;
                h1 {
                    color: @primary-color;
                }
                .demo {
                    width: 100%;
                    margin-bottom: 5%;
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
                            height: auto;
                            margin: 0;
                            margin-bottom: 2.5%;
                            padding: 0;
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
                                margin-top: 2.5%;
                            }
                            .radiobutton {
                                display: inline-block;
                                width: 100%;
                                height: 2.5em;
                                margin-top: 2.5%;
                            }
                            input[type="radio"] {
                                display: inline-block;
                                float: left;
                                height: inherit;
                                max-width: 1.5em;
                                margin: 0;
                                padding: 0;
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
                    }
                }
            }
        }
    </style>
    <script>
        import './menu.tag';
        this.activeItem = 'introduction';
        this.changeActiveItem = (event) => {
            for(let element of event.target.parentNode.children) {
                element.className == 'active' && element.classList.remove('active');
            }
            event.target.classList.add('active');
            this.activeItem = event.target.dataset.id;
            this.update();
            this.refs.main.innerHTML = '';
            this.createTag(event.target.dataset.component, event.target.dataset.label);
        }
        this.items = [
            {"label": "Auth (Multifunctional)", "component": "auth"},
            {"label": "Auth: Register", "component": "auth-register"},
            {"label": "Auth: Login", "component": "auth-login"},
            {"label": "Auth: Reset Password", "component": "auth-reset"},
            {"label": "Comments", "component": "comments"},
            {"label": "Messages", "component": "messages"},
            {"label": "Forum (Multifunctional)", "component": "forum"},
            {"label": "Forum: List", "component": "forum-list"},
            {"label": "Forum: Compose", "component": "forum-compose"},
            {"label": "Forum: Thread", "component": "forum-thread"},
            {"label": "Profile Card", "component": "profile-card"},
            {"label": "Group Card", "component": "group-card"},
            {"label": "State", "component": "state"},
            {"label": "Alert", "component": "alert"}
        ];
        this.createTag = (itemComponent, itemLabel) => {
            let currentElement = document.createElement('docs-' + itemComponent);
            let component = document.createAttribute('component');
            component.value = 'graphjs-' + itemComponent;
            currentElement.setAttributeNode(component);
            let title = document.createAttribute('title');
            title.value = itemLabel;
            currentElement.setAttributeNode(title);
            riot.mount(currentElement);
            this.refs.main.appendChild(currentElement);
        }
    </script>
</docs-index>