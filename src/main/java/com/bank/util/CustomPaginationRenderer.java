package com.bank.util;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

public class CustomPaginationRenderer extends AbstractPaginationRenderer {
	 
	public CustomPaginationRenderer() {
		firstPageLabel ="<li><a href=\"#\" class=\"first\" onclick=\"{0}({1}); return false;\">처음으로</a></li>";
		previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">이전</a>&#160;";
		currentPageLabel = "<strong>{0}</strong>&#160;";
		otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a>&#160;";
		nextPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">다음</a>&#160;";
		lastPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">마지막</a>&#160;";
	}
}

