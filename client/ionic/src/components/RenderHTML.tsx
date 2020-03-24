import React from 'react';
import DOMPurify from 'dompurify';

export default ({ source }: { source: string }) => {
  const cleaned = DOMPurify.sanitize(source, { ALLOWED_TAGS: ['em'] });
  return <div dangerouslySetInnerHTML={{ __html: cleaned }} />;
};
