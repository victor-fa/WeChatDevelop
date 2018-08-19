package com.wwk.message;

import com.wwk.entity.Video;

public class VideoMessage extends BaseMessage {
	// 语音
	private Video Video;

	public Video getVideo() {
		return Video;
	}

	public void setVideo(Video video) {
		Video = video;
	}

}
