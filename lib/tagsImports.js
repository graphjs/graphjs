
// blog
import './tags/blog.tag';
import './tags/blog-list.tag';
import './tags/blog-post.tag';

// comments
import './tags/comments.tag';

// feed
import './tags/feed.tag';
import './tags/feed-activity.tag';
import './tags/feed-composer.tag';
import './tags/feed-display.tag';
import './tags/feed-item.tag';

// feedback
import './tags/feedback.tag';

// forum
import './tags/forum.tag';
import './tags/forum-list.tag';
import './tags/forum-thread.tag';
import './tags/forum-composer.tag';

// groups
import './tags/group.tag';
import './tags/group-card.tag';
import './tags/group-creator.tag';
import './tags/group-header.tag';
import './tags/group-activity.tag';
import './tags/group-members.tag';
import './tags/group-settings.tag';
import './tags/group-list.tag';

// members

// messages
import './tags/messages.tag';
import './tags/messages-composer.tag';

// notifications
import './tags/notifications.tag';
import './tags/notifications-button.tag';
import './tags/notifications-list.tag';

// profile
import './tags/profile.tag';
import './tags/profile-card.tag';
import './tags/profile-header.tag';
import './tags/profile-activity.tag';
import './tags/profile-followers.tag';
import './tags/profile-following.tag';
import './tags/profile-groups.tag';
import './tags/profile-settings.tag';
import './tags/profile-list.tag';

// star
import './tags/star-button.tag';
import './tags/star-list.tag';

// private
import './tags/private-content.tag';

// stripe

// blog
import commentBlogPost from './scripts/commentBlogPost.js';
import editBlogPost from './scripts/editBlogPost.js';
import editBlogComment from './scripts/editBlogComment.js';
import getBlogComments from './scripts/getBlogComments.js';
import getBlogPost from './scripts/getBlogPost.js';
import getBlogPosts from './scripts/getBlogPosts.js';
import removeBlogPost from './scripts/removeBlogPost.js';
import removeBlogComment from './scripts/removeBlogComment.js';
import startBlogPost from './scripts/startBlogPost.js';
import unpublishBlogPost from './scripts/unpublishBlogPost.js';
import showBlog from './scripts/showBlog.js';
import showBlogComposer from './scripts/showBlogComposer.js';
import showBlogList from './scripts/showBlogList.js';
import showBlogPost from './scripts/showBlogPost.js';

// comments
import addComment from './scripts/addComment.js';
import getComments from './scripts/getComments.js';
import removeComment from './scripts/removeComment.js';
import showComments from './scripts/showComments.js';

// feed
import getStatusUpdates from './scripts/getStatusUpdates.js';
import getStatusUpdate from './scripts/getStatusUpdate.js';
import updateStatus from './scripts/updateStatus.js';
import removeStatusUpdate from './scripts/removeStatusUpdate.js';
import showFeedItem from './scripts/showFeedItem.js';

// feedback

// forum
import getThread from './scripts/getThread.js';
import getThreads from './scripts/getThreads.js';
import removeReply from './scripts/removeReply.js';
import replyThread from './scripts/replyThread.js';
import startThread from './scripts/startThread.js';
import showForum from './scripts/showForum.js';
import showForumComposer from './scripts/showForumComposer.js';
import showForumList from './scripts/showForumList.js';
import showForumThread from './scripts/showForumThread.js';

// groups
import createGroup from './scripts/createGroup.js';
import getGroup from './scripts/getGroup.js';
import joinGroup from './scripts/joinGroup.js';
import leaveGroup from './scripts/leaveGroup.js';
import listGroups from './scripts/listGroups.js';
import listMembers from './scripts/listMembers.js';
import setGroupCover from './scripts/setGroupCover.js';
import setGroupDescription from './scripts/setGroupDescription.js';
import setGroupTitle from './scripts/setGroupTitle.js';
import showGroup from './scripts/showGroup.js';
import showGroupCreator from './scripts/showGroupCreator.js';
import deleteGroup from './scripts/deleteGroup.js';

// members
import follow from './scripts/follow.js';
import getFollowers from './scripts/getFollowers.js';
import getFollowing from './scripts/getFollowing.js';
import getMembers from './scripts/getMembers.js';
import unfollow from './scripts/unfollow.js';

// messages
import countUnreadMessages from './scripts/countUnreadMessages.js';
import getConversation from './scripts/getConversation.js';
import getConversations from './scripts/getConversations.js';
import getInbox from './scripts/getInbox.js';
import getMessage from './scripts/getMessage.js';
import getOutbox from './scripts/getOutbox.js';
import sendAnonymousMessage from './scripts/sendAnonymousMessage.js';
import sendMessage from './scripts/sendMessage.js';
import showMessages from './scripts/showMessages.js';
import showMessagesComposer from './scripts/showMessagesComposer.js';

// notifications
import getNotifications from './scripts/getNotifications.js';
import showNotificationsList from './scripts/showNotificationsList.js';

// profile
import getProfile from './scripts/getProfile.js';
import listMemberships from './scripts/listMemberships.js';
import setAvatar from './scripts/setAvatar.js';
import setBio from './scripts/setBio.js';
import setBirthday from './scripts/setBirthday.js';
import setEmail from './scripts/setEmail.js';
import setPassword from './scripts/setPassword.js';
import setProfile from './scripts/setProfile.js';
import setUsername from './scripts/setUsername.js';
import showProfile from './scripts/showProfile.js';

// star
import star from './scripts/star.js';
import getStar from './scripts/getStar.js';
import getStars from './scripts/getStars.js';
import getUserStars from './scripts/getUserStars.js';
import removeStar from './scripts/removeStar.js';

// private
import getPrivateContent from './scripts/getPrivateContent.js';
import removePrivateContent from './scripts/removePrivateContent.js';
import editPrivateContent from './scripts/editPrivateContent.js';
import addPrivateContent from './scripts/addPrivateContent.js';
import listPrivateContents from './scripts/listPrivateContents.js';

// stripe
import createSubscription from './scripts/createSubscription.js';
import checkSubscription from './scripts/checkSubscription.js';
import tokenLogin from './scripts/tokenLogin.js';

export default {
    // blog
    commentBlogPost, editBlogPost, editBlogComment, getBlogComments, getBlogPost, getBlogPosts, removeBlogPost, removeBlogComment, startBlogPost, unpublishBlogPost, showBlog, showBlogComposer, showBlogList, showBlogPost, 
    // comments
    addComment, getComments, removeComment, showComments, 
    // feed
    getStatusUpdates, getStatusUpdate, updateStatus, removeStatusUpdate, showFeedItem, 
    // feedback
    
    // forum
    getThread, getThreads, removeReply, replyThread, startThread, showForum, showForumComposer, showForumList, showForumThread, 
    // groups
    createGroup, getGroup, joinGroup, leaveGroup, listGroups, listMembers, setGroupCover, setGroupDescription, setGroupTitle, showGroup, showGroupCreator, deleteGroup, 
    // members
    follow, getFollowers, getFollowing, getMembers, unfollow, 
    // messages
    countUnreadMessages, getConversation, getConversations, getInbox, getMessage, getOutbox, sendAnonymousMessage, sendMessage, showMessages, showMessagesComposer, 
    // notifications
    getNotifications, showNotificationsList, 
    // profile
    getProfile, listMemberships, setAvatar, setBio, setBirthday, setEmail, setPassword, setProfile, setUsername, showProfile, 
    // star
    star, getStar, getStars, getUserStars, removeStar, 
    // private
    getPrivateContent, removePrivateContent, editPrivateContent, addPrivateContent, listPrivateContents, 
    // stripe
    createSubscription, checkSubscription, tokenLogin, 
}