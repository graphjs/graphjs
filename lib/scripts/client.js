export function downsizeImage(path, width) {
	if(path.includes('cloudinary.com')) {
		return path.replace('/upload/', '/upload/c_limit,w_' + width + '/');
	} else {
		return path;
	}
};

export function getThumbnail(url, size) {
	if(path.includes('cloudinary.com')) {
		return downsizeImage(
			url.substr(0, url.lastIndexOf('.')) + '.jpg',
			size
		);
	}
	else {
		return url;	
	}
};
