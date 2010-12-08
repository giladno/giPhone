//
//  UIDownloadImageView.m
//
//  Created by Gilad Novik on 10-12-07.
//  Copyright 2010 Summit-Tech. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "UIDownloadImageView.h"


@implementation UIDownloadImageView

-(BOOL)downloadWithURL:(NSURL*)url
{
	[self cancel];
	m_connection=[[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:url] delegate:self startImmediately:YES];
	return m_connection!=nil;
}

-(void)cancel
{
	[m_connection cancel];
	[m_connection autorelease];
	m_connection=nil;
	[m_data release];
	m_data=nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	if ([response isKindOfClass:[NSHTTPURLResponse class]])
	{
		if ([(NSHTTPURLResponse*)response statusCode]<400)
		{
			long long nContentLength=[response expectedContentLength];
			m_data=[[NSMutableData alloc] initWithCapacity:(nContentLength!=NSURLResponseUnknownLength) ? nContentLength : 512];
			return;
		}
	}
	[self cancel];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[m_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	self.image=[UIImage imageWithData:m_data];
	[m_connection autorelease];
	m_connection=nil;
	[m_data release];
	m_data=nil;
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[m_connection autorelease];
	m_connection=nil;
	[m_data release];
	m_data=nil;
}

@end

@implementation UIDownloadImageViewWithActivity
@synthesize activityIndicator=m_activity;

-(BOOL)downloadWithURL:(NSURL*)url
{
	if (![super downloadWithURL:url])
		return NO;
	m_activity=[[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
	m_activity.center=CGPointMake(CGRectGetMidX(self.bounds) , CGRectGetMidY(self.bounds));
	[m_activity startAnimating];
	[self addSubview:m_activity];
	return YES;
}

-(void)cancel
{
	[super cancel];
	[m_activity removeFromSuperview];
	m_activity=nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[super connectionDidFinishLoading:connection];
	[m_activity removeFromSuperview];
	m_activity=nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[super connection:connection didFailWithError:error];
	[m_activity removeFromSuperview];
	m_activity=nil;
}


@end

