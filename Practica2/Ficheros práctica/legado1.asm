
legado1:     file format elf32-i386


Disassembly of section .init:

00000584 <.init>:
 584:	53                   	push   %ebx
 585:	83 ec 08             	sub    $0x8,%esp
 588:	e8 83 01 00 00       	call   710 <__gmon_start__@plt+0x48>
 58d:	81 c3 13 2a 00 00    	add    $0x2a13,%ebx
 593:	8b 83 54 00 00 00    	mov    0x54(%ebx),%eax
 599:	85 c0                	test   %eax,%eax
 59b:	74 05                	je     5a2 <strstr@plt-0x1e>
 59d:	e8 26 01 00 00       	call   6c8 <__gmon_start__@plt>
 5a2:	83 c4 08             	add    $0x8,%esp
 5a5:	5b                   	pop    %ebx
 5a6:	c3                   	ret    

Disassembly of section .plt:

000005b0 <strstr@plt-0x10>:
 5b0:	ff b3 04 00 00 00    	pushl  0x4(%ebx)
 5b6:	ff a3 08 00 00 00    	jmp    *0x8(%ebx)
 5bc:	00 00                	add    %al,(%eax)
	...

000005c0 <strstr@plt>:
 5c0:	ff a3 0c 00 00 00    	jmp    *0xc(%ebx)
 5c6:	68 00 00 00 00       	push   $0x0
 5cb:	e9 e0 ff ff ff       	jmp    5b0 <strstr@plt-0x10>

000005d0 <printf@plt>:
 5d0:	ff a3 10 00 00 00    	jmp    *0x10(%ebx)
 5d6:	68 08 00 00 00       	push   $0x8
 5db:	e9 d0 ff ff ff       	jmp    5b0 <strstr@plt-0x10>

000005e0 <getchar@plt>:
 5e0:	ff a3 14 00 00 00    	jmp    *0x14(%ebx)
 5e6:	68 10 00 00 00       	push   $0x10
 5eb:	e9 c0 ff ff ff       	jmp    5b0 <strstr@plt-0x10>

000005f0 <fgets@plt>:
 5f0:	ff a3 18 00 00 00    	jmp    *0x18(%ebx)
 5f6:	68 18 00 00 00       	push   $0x18
 5fb:	e9 b0 ff ff ff       	jmp    5b0 <strstr@plt-0x10>

00000600 <popen@plt>:
 600:	ff a3 1c 00 00 00    	jmp    *0x1c(%ebx)
 606:	68 20 00 00 00       	push   $0x20
 60b:	e9 a0 ff ff ff       	jmp    5b0 <strstr@plt-0x10>

00000610 <__stack_chk_fail@plt>:
 610:	ff a3 20 00 00 00    	jmp    *0x20(%ebx)
 616:	68 28 00 00 00       	push   $0x28
 61b:	e9 90 ff ff ff       	jmp    5b0 <strstr@plt-0x10>

00000620 <__xstat@plt>:
 620:	ff a3 24 00 00 00    	jmp    *0x24(%ebx)
 626:	68 30 00 00 00       	push   $0x30
 62b:	e9 80 ff ff ff       	jmp    5b0 <strstr@plt-0x10>

00000630 <ioperm@plt>:
 630:	ff a3 28 00 00 00    	jmp    *0x28(%ebx)
 636:	68 38 00 00 00       	push   $0x38
 63b:	e9 70 ff ff ff       	jmp    5b0 <strstr@plt-0x10>

00000640 <puts@plt>:
 640:	ff a3 2c 00 00 00    	jmp    *0x2c(%ebx)
 646:	68 40 00 00 00       	push   $0x40
 64b:	e9 60 ff ff ff       	jmp    5b0 <strstr@plt-0x10>

00000650 <system@plt>:
 650:	ff a3 30 00 00 00    	jmp    *0x30(%ebx)
 656:	68 48 00 00 00       	push   $0x48
 65b:	e9 50 ff ff ff       	jmp    5b0 <strstr@plt-0x10>

00000660 <scanf@plt>:
 660:	ff a3 34 00 00 00    	jmp    *0x34(%ebx)
 666:	68 50 00 00 00       	push   $0x50
 66b:	e9 40 ff ff ff       	jmp    5b0 <strstr@plt-0x10>

00000670 <exit@plt>:
 670:	ff a3 38 00 00 00    	jmp    *0x38(%ebx)
 676:	68 58 00 00 00       	push   $0x58
 67b:	e9 30 ff ff ff       	jmp    5b0 <strstr@plt-0x10>

00000680 <pclose@plt>:
 680:	ff a3 3c 00 00 00    	jmp    *0x3c(%ebx)
 686:	68 60 00 00 00       	push   $0x60
 68b:	e9 20 ff ff ff       	jmp    5b0 <strstr@plt-0x10>

00000690 <__libc_start_main@plt>:
 690:	ff a3 40 00 00 00    	jmp    *0x40(%ebx)
 696:	68 68 00 00 00       	push   $0x68
 69b:	e9 10 ff ff ff       	jmp    5b0 <strstr@plt-0x10>

000006a0 <putchar@plt>:
 6a0:	ff a3 44 00 00 00    	jmp    *0x44(%ebx)
 6a6:	68 70 00 00 00       	push   $0x70
 6ab:	e9 00 ff ff ff       	jmp    5b0 <strstr@plt-0x10>

000006b0 <sprintf@plt>:
 6b0:	ff a3 48 00 00 00    	jmp    *0x48(%ebx)
 6b6:	68 78 00 00 00       	push   $0x78
 6bb:	e9 f0 fe ff ff       	jmp    5b0 <strstr@plt-0x10>

Disassembly of section .plt.got:

000006c0 <__cxa_finalize@plt>:
 6c0:	ff a3 50 00 00 00    	jmp    *0x50(%ebx)
 6c6:	66 90                	xchg   %ax,%ax

000006c8 <__gmon_start__@plt>:
 6c8:	ff a3 54 00 00 00    	jmp    *0x54(%ebx)
 6ce:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

000006d0 <.text>:
     6d0:	31 ed                	xor    %ebp,%ebp
     6d2:	5e                   	pop    %esi
     6d3:	89 e1                	mov    %esp,%ecx
     6d5:	83 e4 f0             	and    $0xfffffff0,%esp
     6d8:	50                   	push   %eax
     6d9:	54                   	push   %esp
     6da:	52                   	push   %edx
     6db:	e8 22 00 00 00       	call   702 <__gmon_start__@plt+0x3a>
     6e0:	81 c3 c0 28 00 00    	add    $0x28c0,%ebx
     6e6:	8d 83 f0 e2 ff ff    	lea    -0x1d10(%ebx),%eax
     6ec:	50                   	push   %eax
     6ed:	8d 83 90 e2 ff ff    	lea    -0x1d70(%ebx),%eax
     6f3:	50                   	push   %eax
     6f4:	51                   	push   %ecx
     6f5:	56                   	push   %esi
     6f6:	ff b3 58 00 00 00    	pushl  0x58(%ebx)
     6fc:	e8 8f ff ff ff       	call   690 <__libc_start_main@plt>
     701:	f4                   	hlt    
     702:	8b 1c 24             	mov    (%esp),%ebx
     705:	c3                   	ret    
     706:	66 90                	xchg   %ax,%ax
     708:	66 90                	xchg   %ax,%ax
     70a:	66 90                	xchg   %ax,%ax
     70c:	66 90                	xchg   %ax,%ax
     70e:	66 90                	xchg   %ax,%ax
     710:	8b 1c 24             	mov    (%esp),%ebx
     713:	c3                   	ret    
     714:	66 90                	xchg   %ax,%ax
     716:	66 90                	xchg   %ax,%ax
     718:	66 90                	xchg   %ax,%ax
     71a:	66 90                	xchg   %ax,%ax
     71c:	66 90                	xchg   %ax,%ax
     71e:	66 90                	xchg   %ax,%ax
     720:	e8 e4 00 00 00       	call   809 <__gmon_start__@plt+0x141>
     725:	81 c2 7b 28 00 00    	add    $0x287b,%edx
     72b:	8d 8a b0 09 00 00    	lea    0x9b0(%edx),%ecx
     731:	8d 82 b0 09 00 00    	lea    0x9b0(%edx),%eax
     737:	39 c8                	cmp    %ecx,%eax
     739:	74 1d                	je     758 <__gmon_start__@plt+0x90>
     73b:	8b 82 4c 00 00 00    	mov    0x4c(%edx),%eax
     741:	85 c0                	test   %eax,%eax
     743:	74 13                	je     758 <__gmon_start__@plt+0x90>
     745:	55                   	push   %ebp
     746:	89 e5                	mov    %esp,%ebp
     748:	83 ec 14             	sub    $0x14,%esp
     74b:	51                   	push   %ecx
     74c:	ff d0                	call   *%eax
     74e:	83 c4 10             	add    $0x10,%esp
     751:	c9                   	leave  
     752:	c3                   	ret    
     753:	90                   	nop
     754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     758:	f3 c3                	repz ret 
     75a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     760:	e8 a4 00 00 00       	call   809 <__gmon_start__@plt+0x141>
     765:	81 c2 3b 28 00 00    	add    $0x283b,%edx
     76b:	55                   	push   %ebp
     76c:	8d 8a b0 09 00 00    	lea    0x9b0(%edx),%ecx
     772:	8d 82 b0 09 00 00    	lea    0x9b0(%edx),%eax
     778:	29 c8                	sub    %ecx,%eax
     77a:	89 e5                	mov    %esp,%ebp
     77c:	53                   	push   %ebx
     77d:	c1 f8 02             	sar    $0x2,%eax
     780:	89 c3                	mov    %eax,%ebx
     782:	83 ec 04             	sub    $0x4,%esp
     785:	c1 eb 1f             	shr    $0x1f,%ebx
     788:	01 d8                	add    %ebx,%eax
     78a:	d1 f8                	sar    %eax
     78c:	74 14                	je     7a2 <__gmon_start__@plt+0xda>
     78e:	8b 92 5c 00 00 00    	mov    0x5c(%edx),%edx
     794:	85 d2                	test   %edx,%edx
     796:	74 0a                	je     7a2 <__gmon_start__@plt+0xda>
     798:	83 ec 08             	sub    $0x8,%esp
     79b:	50                   	push   %eax
     79c:	51                   	push   %ecx
     79d:	ff d2                	call   *%edx
     79f:	83 c4 10             	add    $0x10,%esp
     7a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7a5:	c9                   	leave  
     7a6:	c3                   	ret    
     7a7:	89 f6                	mov    %esi,%esi
     7a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     7b0:	55                   	push   %ebp
     7b1:	89 e5                	mov    %esp,%ebp
     7b3:	53                   	push   %ebx
     7b4:	e8 57 ff ff ff       	call   710 <__gmon_start__@plt+0x48>
     7b9:	81 c3 e7 27 00 00    	add    $0x27e7,%ebx
     7bf:	83 ec 04             	sub    $0x4,%esp
     7c2:	80 bb b0 09 00 00 00 	cmpb   $0x0,0x9b0(%ebx)
     7c9:	75 27                	jne    7f2 <__gmon_start__@plt+0x12a>
     7cb:	8b 83 50 00 00 00    	mov    0x50(%ebx),%eax
     7d1:	85 c0                	test   %eax,%eax
     7d3:	74 11                	je     7e6 <__gmon_start__@plt+0x11e>
     7d5:	83 ec 0c             	sub    $0xc,%esp
     7d8:	ff b3 64 00 00 00    	pushl  0x64(%ebx)
     7de:	e8 dd fe ff ff       	call   6c0 <__cxa_finalize@plt>
     7e3:	83 c4 10             	add    $0x10,%esp
     7e6:	e8 35 ff ff ff       	call   720 <__gmon_start__@plt+0x58>
     7eb:	c6 83 b0 09 00 00 01 	movb   $0x1,0x9b0(%ebx)
     7f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7f5:	c9                   	leave  
     7f6:	c3                   	ret    
     7f7:	89 f6                	mov    %esi,%esi
     7f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	5d                   	pop    %ebp
     804:	e9 57 ff ff ff       	jmp    760 <__gmon_start__@plt+0x98>
     809:	8b 14 24             	mov    (%esp),%edx
     80c:	c3                   	ret    
     80d:	55                   	push   %ebp
     80e:	89 e5                	mov    %esp,%ebp
     810:	83 ec 14             	sub    $0x14,%esp
     813:	e8 09 0a 00 00       	call   1221 <__gmon_start__@plt+0xb59>
     818:	05 88 27 00 00       	add    $0x2788,%eax
     81d:	8b 45 08             	mov    0x8(%ebp),%eax
     820:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
     824:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
     828:	89 c2                	mov    %eax,%edx
     82a:	ec                   	in     (%dx),%al
     82b:	88 45 ff             	mov    %al,-0x1(%ebp)
     82e:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
     832:	c9                   	leave  
     833:	c3                   	ret    
     834:	55                   	push   %ebp
     835:	89 e5                	mov    %esp,%ebp
     837:	83 ec 08             	sub    $0x8,%esp
     83a:	e8 e2 09 00 00       	call   1221 <__gmon_start__@plt+0xb59>
     83f:	05 61 27 00 00       	add    $0x2761,%eax
     844:	8b 55 08             	mov    0x8(%ebp),%edx
     847:	8b 45 0c             	mov    0xc(%ebp),%eax
     84a:	88 55 fc             	mov    %dl,-0x4(%ebp)
     84d:	66 89 45 f8          	mov    %ax,-0x8(%ebp)
     851:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
     855:	0f b7 55 f8          	movzwl -0x8(%ebp),%edx
     859:	ee                   	out    %al,(%dx)
     85a:	90                   	nop
     85b:	c9                   	leave  
     85c:	c3                   	ret    
     85d:	55                   	push   %ebp
     85e:	89 e5                	mov    %esp,%ebp
     860:	53                   	push   %ebx
     861:	83 ec 74             	sub    $0x74,%esp
     864:	e8 a7 fe ff ff       	call   710 <__gmon_start__@plt+0x48>
     869:	81 c3 37 27 00 00    	add    $0x2737,%ebx
     86f:	8b 45 08             	mov    0x8(%ebp),%eax
     872:	89 45 94             	mov    %eax,-0x6c(%ebp)
     875:	65 a1 14 00 00 00    	mov    %gs:0x14,%eax
     87b:	89 45 f4             	mov    %eax,-0xc(%ebp)
     87e:	31 c0                	xor    %eax,%eax
     880:	83 ec 08             	sub    $0x8,%esp
     883:	8d 45 9c             	lea    -0x64(%ebp),%eax
     886:	50                   	push   %eax
     887:	ff 75 94             	pushl  -0x6c(%ebp)
     88a:	e8 11 0a 00 00       	call   12a0 <__gmon_start__@plt+0xbd8>
     88f:	83 c4 10             	add    $0x10,%esp
     892:	8b 45 c8             	mov    -0x38(%ebp),%eax
     895:	3d a0 2e 00 00       	cmp    $0x2ea0,%eax
     89a:	74 1e                	je     8ba <__gmon_start__@plt+0x1f2>
     89c:	83 ec 08             	sub    $0x8,%esp
     89f:	6a 02                	push   $0x2
     8a1:	8d 83 60 02 00 00    	lea    0x260(%ebx),%eax
     8a7:	50                   	push   %eax
     8a8:	e8 ee 06 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     8ad:	83 c4 10             	add    $0x10,%esp
     8b0:	83 ec 0c             	sub    $0xc,%esp
     8b3:	6a 01                	push   $0x1
     8b5:	e8 b6 fd ff ff       	call   670 <exit@plt>
     8ba:	90                   	nop
     8bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8be:	65 33 05 14 00 00 00 	xor    %gs:0x14,%eax
     8c5:	74 05                	je     8cc <__gmon_start__@plt+0x204>
     8c7:	e8 04 0a 00 00       	call   12d0 <__gmon_start__@plt+0xc08>
     8cc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8cf:	c9                   	leave  
     8d0:	c3                   	ret    
     8d1:	55                   	push   %ebp
     8d2:	89 e5                	mov    %esp,%ebp
     8d4:	53                   	push   %ebx
     8d5:	81 ec 24 04 00 00    	sub    $0x424,%esp
     8db:	e8 30 fe ff ff       	call   710 <__gmon_start__@plt+0x48>
     8e0:	81 c3 c0 26 00 00    	add    $0x26c0,%ebx
     8e6:	8b 45 08             	mov    0x8(%ebp),%eax
     8e9:	89 85 e4 fb ff ff    	mov    %eax,-0x41c(%ebp)
     8ef:	65 a1 14 00 00 00    	mov    %gs:0x14,%eax
     8f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8f8:	31 c0                	xor    %eax,%eax
     8fa:	83 ec 04             	sub    $0x4,%esp
     8fd:	ff b5 e4 fb ff ff    	pushl  -0x41c(%ebp)
     903:	8d 83 66 e3 ff ff    	lea    -0x1c9a(%ebx),%eax
     909:	50                   	push   %eax
     90a:	8d 85 f4 fb ff ff    	lea    -0x40c(%ebp),%eax
     910:	50                   	push   %eax
     911:	e8 9a fd ff ff       	call   6b0 <sprintf@plt>
     916:	83 c4 10             	add    $0x10,%esp
     919:	83 ec 08             	sub    $0x8,%esp
     91c:	8d 83 6f e3 ff ff    	lea    -0x1c91(%ebx),%eax
     922:	50                   	push   %eax
     923:	8d 85 f4 fb ff ff    	lea    -0x40c(%ebp),%eax
     929:	50                   	push   %eax
     92a:	e8 d1 fc ff ff       	call   600 <popen@plt>
     92f:	83 c4 10             	add    $0x10,%esp
     932:	89 85 f0 fb ff ff    	mov    %eax,-0x410(%ebp)
     938:	83 bd f0 fb ff ff 00 	cmpl   $0x0,-0x410(%ebp)
     93f:	75 1e                	jne    95f <__gmon_start__@plt+0x297>
     941:	83 ec 08             	sub    $0x8,%esp
     944:	6a 03                	push   $0x3
     946:	8d 83 80 05 00 00    	lea    0x580(%ebx),%eax
     94c:	50                   	push   %eax
     94d:	e8 49 06 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     952:	83 c4 10             	add    $0x10,%esp
     955:	83 ec 0c             	sub    $0xc,%esp
     958:	6a ff                	push   $0xffffffff
     95a:	e8 11 fd ff ff       	call   670 <exit@plt>
     95f:	83 ec 04             	sub    $0x4,%esp
     962:	ff b5 f0 fb ff ff    	pushl  -0x410(%ebp)
     968:	68 00 04 00 00       	push   $0x400
     96d:	8d 85 f4 fb ff ff    	lea    -0x40c(%ebp),%eax
     973:	50                   	push   %eax
     974:	e8 77 fc ff ff       	call   5f0 <fgets@plt>
     979:	83 c4 10             	add    $0x10,%esp
     97c:	83 ec 08             	sub    $0x8,%esp
     97f:	8d 83 71 e3 ff ff    	lea    -0x1c8f(%ebx),%eax
     985:	50                   	push   %eax
     986:	8d 85 f4 fb ff ff    	lea    -0x40c(%ebp),%eax
     98c:	50                   	push   %eax
     98d:	e8 2e fc ff ff       	call   5c0 <strstr@plt>
     992:	83 c4 10             	add    $0x10,%esp
     995:	85 c0                	test   %eax,%eax
     997:	75 1e                	jne    9b7 <__gmon_start__@plt+0x2ef>
     999:	83 ec 08             	sub    $0x8,%esp
     99c:	6a 02                	push   $0x2
     99e:	8d 83 80 00 00 00    	lea    0x80(%ebx),%eax
     9a4:	50                   	push   %eax
     9a5:	e8 f1 05 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     9aa:	83 c4 10             	add    $0x10,%esp
     9ad:	83 ec 0c             	sub    $0xc,%esp
     9b0:	6a ff                	push   $0xffffffff
     9b2:	e8 b9 fc ff ff       	call   670 <exit@plt>
     9b7:	83 ec 0c             	sub    $0xc,%esp
     9ba:	ff b5 f0 fb ff ff    	pushl  -0x410(%ebp)
     9c0:	e8 bb fc ff ff       	call   680 <pclose@plt>
     9c5:	83 c4 10             	add    $0x10,%esp
     9c8:	90                   	nop
     9c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9cc:	65 33 05 14 00 00 00 	xor    %gs:0x14,%eax
     9d3:	74 05                	je     9da <__gmon_start__@plt+0x312>
     9d5:	e8 f6 08 00 00       	call   12d0 <__gmon_start__@plt+0xc08>
     9da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9dd:	c9                   	leave  
     9de:	c3                   	ret    
     9df:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     9e3:	83 e4 f0             	and    $0xfffffff0,%esp
     9e6:	ff 71 fc             	pushl  -0x4(%ecx)
     9e9:	55                   	push   %ebp
     9ea:	89 e5                	mov    %esp,%ebp
     9ec:	53                   	push   %ebx
     9ed:	51                   	push   %ecx
     9ee:	83 ec 20             	sub    $0x20,%esp
     9f1:	e8 1a fd ff ff       	call   710 <__gmon_start__@plt+0x48>
     9f6:	81 c3 aa 25 00 00    	add    $0x25aa,%ebx
     9fc:	89 c8                	mov    %ecx,%eax
     9fe:	8b 40 04             	mov    0x4(%eax),%eax
     a01:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     a04:	65 a1 14 00 00 00    	mov    %gs:0x14,%eax
     a0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
     a0d:	31 c0                	xor    %eax,%eax
     a0f:	83 ec 0c             	sub    $0xc,%esp
     a12:	8d 83 75 e3 ff ff    	lea    -0x1c8b(%ebx),%eax
     a18:	50                   	push   %eax
     a19:	e8 22 fc ff ff       	call   640 <puts@plt>
     a1e:	83 c4 10             	add    $0x10,%esp
     a21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a24:	8b 00                	mov    (%eax),%eax
     a26:	83 ec 0c             	sub    $0xc,%esp
     a29:	50                   	push   %eax
     a2a:	e8 a2 fe ff ff       	call   8d1 <__gmon_start__@plt+0x209>
     a2f:	83 c4 10             	add    $0x10,%esp
     a32:	e8 77 04 00 00       	call   eae <__gmon_start__@plt+0x7e6>
     a37:	83 ec 04             	sub    $0x4,%esp
     a3a:	6a 01                	push   $0x1
     a3c:	6a 02                	push   $0x2
     a3e:	50                   	push   %eax
     a3f:	e8 ec fb ff ff       	call   630 <ioperm@plt>
     a44:	83 c4 10             	add    $0x10,%esp
     a47:	85 c0                	test   %eax,%eax
     a49:	0f 95 c0             	setne  %al
     a4c:	84 c0                	test   %al,%al
     a4e:	74 1e                	je     a6e <__gmon_start__@plt+0x3a6>
     a50:	83 ec 08             	sub    $0x8,%esp
     a53:	6a 02                	push   $0x2
     a55:	8d 83 c0 01 00 00    	lea    0x1c0(%ebx),%eax
     a5b:	50                   	push   %eax
     a5c:	e8 3a 05 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     a61:	83 c4 10             	add    $0x10,%esp
     a64:	83 ec 0c             	sub    $0xc,%esp
     a67:	6a 01                	push   $0x1
     a69:	e8 02 fc ff ff       	call   670 <exit@plt>
     a6e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a71:	8b 00                	mov    (%eax),%eax
     a73:	83 ec 0c             	sub    $0xc,%esp
     a76:	50                   	push   %eax
     a77:	e8 e1 fd ff ff       	call   85d <__gmon_start__@plt+0x195>
     a7c:	83 c4 10             	add    $0x10,%esp
     a7f:	83 ec 0c             	sub    $0xc,%esp
     a82:	6a 4d                	push   $0x4d
     a84:	e8 56 04 00 00       	call   edf <__gmon_start__@plt+0x817>
     a89:	83 c4 10             	add    $0x10,%esp
     a8c:	85 c0                	test   %eax,%eax
     a8e:	74 0c                	je     a9c <__gmon_start__@plt+0x3d4>
     a90:	c7 83 b4 09 00 00 01 	movl   $0x1,0x9b4(%ebx)
     a97:	00 00 00 
     a9a:	eb 0a                	jmp    aa6 <__gmon_start__@plt+0x3de>
     a9c:	c7 83 b4 09 00 00 00 	movl   $0x0,0x9b4(%ebx)
     aa3:	00 00 00 
     aa6:	83 ec 0c             	sub    $0xc,%esp
     aa9:	6a 4d                	push   $0x4d
     aab:	e8 2f 04 00 00       	call   edf <__gmon_start__@plt+0x817>
     ab0:	83 c4 10             	add    $0x10,%esp
     ab3:	85 c0                	test   %eax,%eax
     ab5:	0f 94 c0             	sete   %al
     ab8:	84 c0                	test   %al,%al
     aba:	74 1e                	je     ada <__gmon_start__@plt+0x412>
     abc:	83 ec 08             	sub    $0x8,%esp
     abf:	6a 02                	push   $0x2
     ac1:	8d 83 20 01 00 00    	lea    0x120(%ebx),%eax
     ac7:	50                   	push   %eax
     ac8:	e8 ce 04 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     acd:	83 c4 10             	add    $0x10,%esp
     ad0:	83 ec 0c             	sub    $0xc,%esp
     ad3:	6a 01                	push   $0x1
     ad5:	e8 96 fb ff ff       	call   670 <exit@plt>
     ada:	90                   	nop
     adb:	83 ec 0c             	sub    $0xc,%esp
     ade:	8d 83 60 e3 ff ff    	lea    -0x1ca0(%ebx),%eax
     ae4:	50                   	push   %eax
     ae5:	e8 66 fb ff ff       	call   650 <system@plt>
     aea:	83 c4 10             	add    $0x10,%esp
     aed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     af0:	8b 00                	mov    (%eax),%eax
     af2:	83 ec 0c             	sub    $0xc,%esp
     af5:	50                   	push   %eax
     af6:	e8 62 fd ff ff       	call   85d <__gmon_start__@plt+0x195>
     afb:	83 c4 10             	add    $0x10,%esp
     afe:	83 ec 08             	sub    $0x8,%esp
     b01:	6a 02                	push   $0x2
     b03:	8d 83 40 06 00 00    	lea    0x640(%ebx),%eax
     b09:	50                   	push   %eax
     b0a:	e8 8c 04 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     b0f:	83 c4 10             	add    $0x10,%esp
     b12:	83 ec 08             	sub    $0x8,%esp
     b15:	6a 02                	push   $0x2
     b17:	8d 83 c0 06 00 00    	lea    0x6c0(%ebx),%eax
     b1d:	50                   	push   %eax
     b1e:	e8 78 04 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     b23:	83 c4 10             	add    $0x10,%esp
     b26:	83 ec 08             	sub    $0x8,%esp
     b29:	6a 02                	push   $0x2
     b2b:	8d 83 60 07 00 00    	lea    0x760(%ebx),%eax
     b31:	50                   	push   %eax
     b32:	e8 64 04 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     b37:	83 c4 10             	add    $0x10,%esp
     b3a:	83 ec 08             	sub    $0x8,%esp
     b3d:	6a 03                	push   $0x3
     b3f:	8d 83 c0 07 00 00    	lea    0x7c0(%ebx),%eax
     b45:	50                   	push   %eax
     b46:	e8 50 04 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     b4b:	83 c4 10             	add    $0x10,%esp
     b4e:	83 ec 08             	sub    $0x8,%esp
     b51:	6a 03                	push   $0x3
     b53:	8d 83 20 08 00 00    	lea    0x820(%ebx),%eax
     b59:	50                   	push   %eax
     b5a:	e8 3c 04 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     b5f:	83 c4 10             	add    $0x10,%esp
     b62:	83 ec 08             	sub    $0x8,%esp
     b65:	6a 02                	push   $0x2
     b67:	8d 83 80 08 00 00    	lea    0x880(%ebx),%eax
     b6d:	50                   	push   %eax
     b6e:	e8 28 04 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     b73:	83 c4 10             	add    $0x10,%esp
     b76:	83 ec 08             	sub    $0x8,%esp
     b79:	6a 02                	push   $0x2
     b7b:	8d 83 e0 08 00 00    	lea    0x8e0(%ebx),%eax
     b81:	50                   	push   %eax
     b82:	e8 14 04 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     b87:	83 c4 10             	add    $0x10,%esp
     b8a:	83 ec 08             	sub    $0x8,%esp
     b8d:	6a 02                	push   $0x2
     b8f:	8d 83 40 09 00 00    	lea    0x940(%ebx),%eax
     b95:	50                   	push   %eax
     b96:	e8 00 04 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     b9b:	83 c4 10             	add    $0x10,%esp
     b9e:	83 ec 0c             	sub    $0xc,%esp
     ba1:	8d 83 7c e3 ff ff    	lea    -0x1c84(%ebx),%eax
     ba7:	50                   	push   %eax
     ba8:	e8 23 fa ff ff       	call   5d0 <printf@plt>
     bad:	83 c4 10             	add    $0x10,%esp
     bb0:	83 ec 08             	sub    $0x8,%esp
     bb3:	8d 45 ec             	lea    -0x14(%ebp),%eax
     bb6:	50                   	push   %eax
     bb7:	8d 83 86 e3 ff ff    	lea    -0x1c7a(%ebx),%eax
     bbd:	50                   	push   %eax
     bbe:	e8 9d fa ff ff       	call   660 <scanf@plt>
     bc3:	83 c4 10             	add    $0x10,%esp
     bc6:	8b 83 b4 09 00 00    	mov    0x9b4(%ebx),%eax
     bcc:	85 c0                	test   %eax,%eax
     bce:	0f 84 a9 02 00 00    	je     e7d <__gmon_start__@plt+0x7b5>
     bd4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bd7:	83 f8 01             	cmp    $0x1,%eax
     bda:	75 07                	jne    be3 <__gmon_start__@plt+0x51b>
     bdc:	b8 01 00 00 00       	mov    $0x1,%eax
     be1:	eb 05                	jmp    be8 <__gmon_start__@plt+0x520>
     be3:	b8 00 00 00 00       	mov    $0x0,%eax
     be8:	84 c0                	test   %al,%al
     bea:	74 4a                	je     c36 <__gmon_start__@plt+0x56e>
     bec:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bef:	83 f8 01             	cmp    $0x1,%eax
     bf2:	74 1b                	je     c0f <__gmon_start__@plt+0x547>
     bf4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bf7:	6b c0 22             	imul   $0x22,%eax,%eax
     bfa:	83 e8 02             	sub    $0x2,%eax
     bfd:	89 45 ec             	mov    %eax,-0x14(%ebp)
     c00:	83 ec 0c             	sub    $0xc,%esp
     c03:	6a 17                	push   $0x17
     c05:	e8 d5 02 00 00       	call   edf <__gmon_start__@plt+0x817>
     c0a:	83 c4 10             	add    $0x10,%esp
     c0d:	eb dd                	jmp    bec <__gmon_start__@plt+0x524>
     c0f:	8b 83 a4 09 00 00    	mov    0x9a4(%ebx),%eax
     c15:	83 c0 2f             	add    $0x2f,%eax
     c18:	83 ec 0c             	sub    $0xc,%esp
     c1b:	50                   	push   %eax
     c1c:	e8 be 02 00 00       	call   edf <__gmon_start__@plt+0x817>
     c21:	83 c4 10             	add    $0x10,%esp
     c24:	85 c0                	test   %eax,%eax
     c26:	0f 95 c0             	setne  %al
     c29:	84 c0                	test   %al,%al
     c2b:	0f 84 2a 02 00 00    	je     e5b <__gmon_start__@plt+0x793>
     c31:	e9 5f 02 00 00       	jmp    e95 <__gmon_start__@plt+0x7cd>
     c36:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c39:	83 f8 02             	cmp    $0x2,%eax
     c3c:	75 07                	jne    c45 <__gmon_start__@plt+0x57d>
     c3e:	b8 01 00 00 00       	mov    $0x1,%eax
     c43:	eb 05                	jmp    c4a <__gmon_start__@plt+0x582>
     c45:	b8 00 00 00 00       	mov    $0x0,%eax
     c4a:	84 c0                	test   %al,%al
     c4c:	0f 84 8e 00 00 00    	je     ce0 <__gmon_start__@plt+0x618>
     c52:	83 ec 0c             	sub    $0xc,%esp
     c55:	6a 4d                	push   $0x4d
     c57:	e8 83 02 00 00       	call   edf <__gmon_start__@plt+0x817>
     c5c:	83 c4 10             	add    $0x10,%esp
     c5f:	85 c0                	test   %eax,%eax
     c61:	0f 94 c0             	sete   %al
     c64:	84 c0                	test   %al,%al
     c66:	74 2f                	je     c97 <__gmon_start__@plt+0x5cf>
     c68:	83 ec 08             	sub    $0x8,%esp
     c6b:	6a 02                	push   $0x2
     c6d:	8d 83 20 01 00 00    	lea    0x120(%ebx),%eax
     c73:	50                   	push   %eax
     c74:	e8 22 03 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     c79:	83 c4 10             	add    $0x10,%esp
     c7c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c7f:	8b 00                	mov    (%eax),%eax
     c81:	83 ec 0c             	sub    $0xc,%esp
     c84:	50                   	push   %eax
     c85:	e8 d3 fb ff ff       	call   85d <__gmon_start__@plt+0x195>
     c8a:	83 c4 10             	add    $0x10,%esp
     c8d:	83 ec 0c             	sub    $0xc,%esp
     c90:	6a 01                	push   $0x1
     c92:	e8 d9 f9 ff ff       	call   670 <exit@plt>
     c97:	e8 b9 03 00 00       	call   1055 <__gmon_start__@plt+0x98d>
     c9c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c9f:	8b 00                	mov    (%eax),%eax
     ca1:	83 ec 0c             	sub    $0xc,%esp
     ca4:	50                   	push   %eax
     ca5:	e8 b3 fb ff ff       	call   85d <__gmon_start__@plt+0x195>
     caa:	83 c4 10             	add    $0x10,%esp
     cad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     cb0:	8b 00                	mov    (%eax),%eax
     cb2:	83 ec 0c             	sub    $0xc,%esp
     cb5:	50                   	push   %eax
     cb6:	e8 a2 fb ff ff       	call   85d <__gmon_start__@plt+0x195>
     cbb:	83 c4 10             	add    $0x10,%esp
     cbe:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cc1:	83 f8 02             	cmp    $0x2,%eax
     cc4:	0f 84 11 fe ff ff    	je     adb <__gmon_start__@plt+0x413>
     cca:	c7 45 ec 21 00 00 00 	movl   $0x21,-0x14(%ebp)
     cd1:	83 ec 0c             	sub    $0xc,%esp
     cd4:	6a 11                	push   $0x11
     cd6:	e8 04 02 00 00       	call   edf <__gmon_start__@plt+0x817>
     cdb:	83 c4 10             	add    $0x10,%esp
     cde:	eb de                	jmp    cbe <__gmon_start__@plt+0x5f6>
     ce0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ce3:	83 f8 03             	cmp    $0x3,%eax
     ce6:	75 3c                	jne    d24 <__gmon_start__@plt+0x65c>
     ce8:	8b 83 ac 09 00 00    	mov    0x9ac(%ebx),%eax
     cee:	8b 00                	mov    (%eax),%eax
     cf0:	85 c0                	test   %eax,%eax
     cf2:	0f 84 e3 fd ff ff    	je     adb <__gmon_start__@plt+0x413>
     cf8:	8b 83 a8 09 00 00    	mov    0x9a8(%ebx),%eax
     cfe:	83 c0 06             	add    $0x6,%eax
     d01:	83 ec 0c             	sub    $0xc,%esp
     d04:	50                   	push   %eax
     d05:	e8 d5 01 00 00       	call   edf <__gmon_start__@plt+0x817>
     d0a:	83 c4 10             	add    $0x10,%esp
     d0d:	85 c0                	test   %eax,%eax
     d0f:	0f 95 c0             	setne  %al
     d12:	84 c0                	test   %al,%al
     d14:	0f 84 44 01 00 00    	je     e5e <__gmon_start__@plt+0x796>
     d1a:	e8 92 03 00 00       	call   10b1 <__gmon_start__@plt+0x9e9>
     d1f:	e9 b7 fd ff ff       	jmp    adb <__gmon_start__@plt+0x413>
     d24:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d27:	83 f8 04             	cmp    $0x4,%eax
     d2a:	75 3d                	jne    d69 <__gmon_start__@plt+0x6a1>
     d2c:	8b 83 a4 09 00 00    	mov    0x9a4(%ebx),%eax
     d32:	83 c0 2f             	add    $0x2f,%eax
     d35:	83 ec 0c             	sub    $0xc,%esp
     d38:	50                   	push   %eax
     d39:	e8 a1 01 00 00       	call   edf <__gmon_start__@plt+0x817>
     d3e:	83 c4 10             	add    $0x10,%esp
     d41:	85 c0                	test   %eax,%eax
     d43:	0f 95 c0             	setne  %al
     d46:	84 c0                	test   %al,%al
     d48:	0f 84 32 01 00 00    	je     e80 <__gmon_start__@plt+0x7b8>
     d4e:	e8 ba 03 00 00       	call   110d <__gmon_start__@plt+0xa45>
     d53:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d56:	8b 00                	mov    (%eax),%eax
     d58:	83 ec 0c             	sub    $0xc,%esp
     d5b:	50                   	push   %eax
     d5c:	e8 fc fa ff ff       	call   85d <__gmon_start__@plt+0x195>
     d61:	83 c4 10             	add    $0x10,%esp
     d64:	e9 72 fd ff ff       	jmp    adb <__gmon_start__@plt+0x413>
     d69:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d6c:	83 f8 05             	cmp    $0x5,%eax
     d6f:	75 46                	jne    db7 <__gmon_start__@plt+0x6ef>
     d71:	8b 83 a4 09 00 00    	mov    0x9a4(%ebx),%eax
     d77:	83 c0 2f             	add    $0x2f,%eax
     d7a:	83 ec 0c             	sub    $0xc,%esp
     d7d:	50                   	push   %eax
     d7e:	e8 5c 01 00 00       	call   edf <__gmon_start__@plt+0x817>
     d83:	83 c4 10             	add    $0x10,%esp
     d86:	85 c0                	test   %eax,%eax
     d88:	0f 95 c0             	setne  %al
     d8b:	84 c0                	test   %al,%al
     d8d:	74 0a                	je     d99 <__gmon_start__@plt+0x6d1>
     d8f:	e8 d5 03 00 00       	call   1169 <__gmon_start__@plt+0xaa1>
     d94:	e9 42 fd ff ff       	jmp    adb <__gmon_start__@plt+0x413>
     d99:	83 ec 08             	sub    $0x8,%esp
     d9c:	6a 02                	push   $0x2
     d9e:	8d 83 20 01 00 00    	lea    0x120(%ebx),%eax
     da4:	50                   	push   %eax
     da5:	e8 f1 01 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     daa:	83 c4 10             	add    $0x10,%esp
     dad:	83 ec 0c             	sub    $0xc,%esp
     db0:	6a 01                	push   $0x1
     db2:	e8 b9 f8 ff ff       	call   670 <exit@plt>
     db7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     dba:	83 f8 06             	cmp    $0x6,%eax
     dbd:	75 6c                	jne    e2b <__gmon_start__@plt+0x763>
     dbf:	8b 83 ac 09 00 00    	mov    0x9ac(%ebx),%eax
     dc5:	8b 00                	mov    (%eax),%eax
     dc7:	85 c0                	test   %eax,%eax
     dc9:	74 18                	je     de3 <__gmon_start__@plt+0x71b>
     dcb:	83 ec 0c             	sub    $0xc,%esp
     dce:	6a 4d                	push   $0x4d
     dd0:	e8 0a 01 00 00       	call   edf <__gmon_start__@plt+0x817>
     dd5:	83 c4 10             	add    $0x10,%esp
     dd8:	85 c0                	test   %eax,%eax
     dda:	74 07                	je     de3 <__gmon_start__@plt+0x71b>
     ddc:	b8 01 00 00 00       	mov    $0x1,%eax
     de1:	eb 05                	jmp    de8 <__gmon_start__@plt+0x720>
     de3:	b8 00 00 00 00       	mov    $0x0,%eax
     de8:	84 c0                	test   %al,%al
     dea:	74 0e                	je     dfa <__gmon_start__@plt+0x732>
     dec:	e8 d4 03 00 00       	call   11c5 <__gmon_start__@plt+0xafd>
     df1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     df8:	eb 1e                	jmp    e18 <__gmon_start__@plt+0x750>
     dfa:	83 ec 08             	sub    $0x8,%esp
     dfd:	6a 02                	push   $0x2
     dff:	8d 83 20 01 00 00    	lea    0x120(%ebx),%eax
     e05:	50                   	push   %eax
     e06:	e8 90 01 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     e0b:	83 c4 10             	add    $0x10,%esp
     e0e:	83 ec 0c             	sub    $0xc,%esp
     e11:	6a 01                	push   $0x1
     e13:	e8 58 f8 ff ff       	call   670 <exit@plt>
     e18:	81 7d f0 e7 03 00 00 	cmpl   $0x3e7,-0x10(%ebp)
     e1f:	0f 8f b6 fc ff ff    	jg     adb <__gmon_start__@plt+0x413>
     e25:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     e29:	eb ed                	jmp    e18 <__gmon_start__@plt+0x750>
     e2b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e2e:	83 f8 07             	cmp    $0x7,%eax
     e31:	0f 85 a4 fc ff ff    	jne    adb <__gmon_start__@plt+0x413>
     e37:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     e3a:	8b 00                	mov    (%eax),%eax
     e3c:	83 ec 0c             	sub    $0xc,%esp
     e3f:	50                   	push   %eax
     e40:	e8 18 fa ff ff       	call   85d <__gmon_start__@plt+0x195>
     e45:	83 c4 10             	add    $0x10,%esp
     e48:	b8 00 00 00 00       	mov    $0x0,%eax
     e4d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e50:	65 33 15 14 00 00 00 	xor    %gs:0x14,%edx
     e57:	74 4b                	je     ea4 <__gmon_start__@plt+0x7dc>
     e59:	eb 44                	jmp    e9f <__gmon_start__@plt+0x7d7>
     e5b:	90                   	nop
     e5c:	eb 01                	jmp    e5f <__gmon_start__@plt+0x797>
     e5e:	90                   	nop
     e5f:	83 ec 08             	sub    $0x8,%esp
     e62:	6a 02                	push   $0x2
     e64:	8d 83 20 01 00 00    	lea    0x120(%ebx),%eax
     e6a:	50                   	push   %eax
     e6b:	e8 2b 01 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     e70:	83 c4 10             	add    $0x10,%esp
     e73:	83 ec 0c             	sub    $0xc,%esp
     e76:	6a 01                	push   $0x1
     e78:	e8 f3 f7 ff ff       	call   670 <exit@plt>
     e7d:	90                   	nop
     e7e:	eb 01                	jmp    e81 <__gmon_start__@plt+0x7b9>
     e80:	90                   	nop
     e81:	83 ec 08             	sub    $0x8,%esp
     e84:	6a 02                	push   $0x2
     e86:	8d 83 20 01 00 00    	lea    0x120(%ebx),%eax
     e8c:	50                   	push   %eax
     e8d:	e8 09 01 00 00       	call   f9b <__gmon_start__@plt+0x8d3>
     e92:	83 c4 10             	add    $0x10,%esp
     e95:	e8 5f 01 00 00       	call   ff9 <__gmon_start__@plt+0x931>
     e9a:	e9 3c fc ff ff       	jmp    adb <__gmon_start__@plt+0x413>
     e9f:	e8 2c 04 00 00       	call   12d0 <__gmon_start__@plt+0xc08>
     ea4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ea7:	59                   	pop    %ecx
     ea8:	5b                   	pop    %ebx
     ea9:	5d                   	pop    %ebp
     eaa:	8d 61 fc             	lea    -0x4(%ecx),%esp
     ead:	c3                   	ret    
     eae:	55                   	push   %ebp
     eaf:	89 e5                	mov    %esp,%ebp
     eb1:	83 ec 10             	sub    $0x10,%esp
     eb4:	e8 68 03 00 00       	call   1221 <__gmon_start__@plt+0xb59>
     eb9:	05 e7 20 00 00       	add    $0x20e7,%eax
     ebe:	c7 45 f4 00 01 00 00 	movl   $0x100,-0xc(%ebp)
     ec5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ec8:	89 d0                	mov    %edx,%eax
     eca:	01 c0                	add    %eax,%eax
     ecc:	01 d0                	add    %edx,%eax
     ece:	89 45 f8             	mov    %eax,-0x8(%ebp)
     ed1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ed4:	83 c0 78             	add    $0x78,%eax
     ed7:	89 45 fc             	mov    %eax,-0x4(%ebp)
     eda:	8b 45 fc             	mov    -0x4(%ebp),%eax
     edd:	c9                   	leave  
     ede:	c3                   	ret    
     edf:	55                   	push   %ebp
     ee0:	89 e5                	mov    %esp,%ebp
     ee2:	53                   	push   %ebx
     ee3:	83 ec 24             	sub    $0x24,%esp
     ee6:	e8 36 03 00 00       	call   1221 <__gmon_start__@plt+0xb59>
     eeb:	05 b5 20 00 00       	add    $0x20b5,%eax
     ef0:	65 a1 14 00 00 00    	mov    %gs:0x14,%eax
     ef6:	89 45 f4             	mov    %eax,-0xc(%ebp)
     ef9:	31 c0                	xor    %eax,%eax
     efb:	c7 45 dc 7b 00 00 00 	movl   $0x7b,-0x24(%ebp)
     f02:	c7 45 e0 ea 00 00 00 	movl   $0xea,-0x20(%ebp)
     f09:	c7 45 e4 d5 00 00 00 	movl   $0xd5,-0x1c(%ebp)
     f10:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
     f17:	c7 45 ec 4d 00 00 00 	movl   $0x4d,-0x14(%ebp)
     f1e:	c7 45 f0 63 00 00 00 	movl   $0x63,-0x10(%ebp)
     f25:	e8 84 ff ff ff       	call   eae <__gmon_start__@plt+0x7e6>
     f2a:	0f b7 d0             	movzwl %ax,%edx
     f2d:	8b 45 08             	mov    0x8(%ebp),%eax
     f30:	0f b6 c0             	movzbl %al,%eax
     f33:	83 ec 08             	sub    $0x8,%esp
     f36:	52                   	push   %edx
     f37:	50                   	push   %eax
     f38:	e8 f7 f8 ff ff       	call   834 <__gmon_start__@plt+0x16c>
     f3d:	83 c4 10             	add    $0x10,%esp
     f40:	e8 69 ff ff ff       	call   eae <__gmon_start__@plt+0x7e6>
     f45:	0f b7 c0             	movzwl %ax,%eax
     f48:	83 ec 0c             	sub    $0xc,%esp
     f4b:	50                   	push   %eax
     f4c:	e8 bc f8 ff ff       	call   80d <__gmon_start__@plt+0x145>
     f51:	83 c4 10             	add    $0x10,%esp
     f54:	0f b6 d8             	movzbl %al,%ebx
     f57:	8b 4d 08             	mov    0x8(%ebp),%ecx
     f5a:	ba 67 66 66 66       	mov    $0x66666667,%edx
     f5f:	89 c8                	mov    %ecx,%eax
     f61:	f7 ea                	imul   %edx
     f63:	d1 fa                	sar    %edx
     f65:	89 c8                	mov    %ecx,%eax
     f67:	c1 f8 1f             	sar    $0x1f,%eax
     f6a:	29 c2                	sub    %eax,%edx
     f6c:	89 d0                	mov    %edx,%eax
     f6e:	89 c2                	mov    %eax,%edx
     f70:	c1 e2 02             	shl    $0x2,%edx
     f73:	01 c2                	add    %eax,%edx
     f75:	89 c8                	mov    %ecx,%eax
     f77:	29 d0                	sub    %edx,%eax
     f79:	8b 44 85 dc          	mov    -0x24(%ebp,%eax,4),%eax
     f7d:	39 c3                	cmp    %eax,%ebx
     f7f:	0f 94 c0             	sete   %al
     f82:	0f b6 c0             	movzbl %al,%eax
     f85:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     f88:	65 33 1d 14 00 00 00 	xor    %gs:0x14,%ebx
     f8f:	74 05                	je     f96 <__gmon_start__@plt+0x8ce>
     f91:	e8 3a 03 00 00       	call   12d0 <__gmon_start__@plt+0xc08>
     f96:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     f99:	c9                   	leave  
     f9a:	c3                   	ret    
     f9b:	55                   	push   %ebp
     f9c:	89 e5                	mov    %esp,%ebp
     f9e:	53                   	push   %ebx
     f9f:	83 ec 14             	sub    $0x14,%esp
     fa2:	e8 69 f7 ff ff       	call   710 <__gmon_start__@plt+0x48>
     fa7:	81 c3 f9 1f 00 00    	add    $0x1ff9,%ebx
     fad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     fb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fb7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     fbe:	8b 45 08             	mov    0x8(%ebp),%eax
     fc1:	01 d0                	add    %edx,%eax
     fc3:	8b 00                	mov    (%eax),%eax
     fc5:	85 c0                	test   %eax,%eax
     fc7:	74 2a                	je     ff3 <__gmon_start__@plt+0x92b>
     fc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fcc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     fd3:	8b 45 08             	mov    0x8(%ebp),%eax
     fd6:	01 d0                	add    %edx,%eax
     fd8:	8b 00                	mov    (%eax),%eax
     fda:	99                   	cltd   
     fdb:	f7 7d 0c             	idivl  0xc(%ebp)
     fde:	0f be c0             	movsbl %al,%eax
     fe1:	83 ec 0c             	sub    $0xc,%esp
     fe4:	50                   	push   %eax
     fe5:	e8 b6 f6 ff ff       	call   6a0 <putchar@plt>
     fea:	83 c4 10             	add    $0x10,%esp
     fed:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     ff1:	eb c1                	jmp    fb4 <__gmon_start__@plt+0x8ec>
     ff3:	90                   	nop
     ff4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ff7:	c9                   	leave  
     ff8:	c3                   	ret    
     ff9:	55                   	push   %ebp
     ffa:	89 e5                	mov    %esp,%ebp
     ffc:	53                   	push   %ebx
     ffd:	83 ec 04             	sub    $0x4,%esp
    1000:	e8 0b f7 ff ff       	call   710 <__gmon_start__@plt+0x48>
    1005:	81 c3 9b 1f 00 00    	add    $0x1f9b,%ebx
    100b:	83 ec 0c             	sub    $0xc,%esp
    100e:	8d 83 60 e3 ff ff    	lea    -0x1ca0(%ebx),%eax
    1014:	50                   	push   %eax
    1015:	e8 36 f6 ff ff       	call   650 <system@plt>
    101a:	83 c4 10             	add    $0x10,%esp
    101d:	83 ec 08             	sub    $0x8,%esp
    1020:	6a 02                	push   $0x2
    1022:	8d 83 e0 02 00 00    	lea    0x2e0(%ebx),%eax
    1028:	50                   	push   %eax
    1029:	e8 6d ff ff ff       	call   f9b <__gmon_start__@plt+0x8d3>
    102e:	83 c4 10             	add    $0x10,%esp
    1031:	83 ec 08             	sub    $0x8,%esp
    1034:	6a 03                	push   $0x3
    1036:	8d 83 60 03 00 00    	lea    0x360(%ebx),%eax
    103c:	50                   	push   %eax
    103d:	e8 59 ff ff ff       	call   f9b <__gmon_start__@plt+0x8d3>
    1042:	83 c4 10             	add    $0x10,%esp
    1045:	e8 96 f5 ff ff       	call   5e0 <getchar@plt>
    104a:	e8 91 f5 ff ff       	call   5e0 <getchar@plt>
    104f:	90                   	nop
    1050:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1053:	c9                   	leave  
    1054:	c3                   	ret    
    1055:	55                   	push   %ebp
    1056:	89 e5                	mov    %esp,%ebp
    1058:	53                   	push   %ebx
    1059:	83 ec 04             	sub    $0x4,%esp
    105c:	e8 af f6 ff ff       	call   710 <__gmon_start__@plt+0x48>
    1061:	81 c3 3f 1f 00 00    	add    $0x1f3f,%ebx
    1067:	83 ec 0c             	sub    $0xc,%esp
    106a:	8d 83 60 e3 ff ff    	lea    -0x1ca0(%ebx),%eax
    1070:	50                   	push   %eax
    1071:	e8 da f5 ff ff       	call   650 <system@plt>
    1076:	83 c4 10             	add    $0x10,%esp
    1079:	83 ec 08             	sub    $0x8,%esp
    107c:	6a 04                	push   $0x4
    107e:	8d 83 c0 03 00 00    	lea    0x3c0(%ebx),%eax
    1084:	50                   	push   %eax
    1085:	e8 11 ff ff ff       	call   f9b <__gmon_start__@plt+0x8d3>
    108a:	83 c4 10             	add    $0x10,%esp
    108d:	83 ec 08             	sub    $0x8,%esp
    1090:	6a 03                	push   $0x3
    1092:	8d 83 60 03 00 00    	lea    0x360(%ebx),%eax
    1098:	50                   	push   %eax
    1099:	e8 fd fe ff ff       	call   f9b <__gmon_start__@plt+0x8d3>
    109e:	83 c4 10             	add    $0x10,%esp
    10a1:	e8 3a f5 ff ff       	call   5e0 <getchar@plt>
    10a6:	e8 35 f5 ff ff       	call   5e0 <getchar@plt>
    10ab:	90                   	nop
    10ac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    10af:	c9                   	leave  
    10b0:	c3                   	ret    
    10b1:	55                   	push   %ebp
    10b2:	89 e5                	mov    %esp,%ebp
    10b4:	53                   	push   %ebx
    10b5:	83 ec 04             	sub    $0x4,%esp
    10b8:	e8 53 f6 ff ff       	call   710 <__gmon_start__@plt+0x48>
    10bd:	81 c3 e3 1e 00 00    	add    $0x1ee3,%ebx
    10c3:	83 ec 0c             	sub    $0xc,%esp
    10c6:	8d 83 60 e3 ff ff    	lea    -0x1ca0(%ebx),%eax
    10cc:	50                   	push   %eax
    10cd:	e8 7e f5 ff ff       	call   650 <system@plt>
    10d2:	83 c4 10             	add    $0x10,%esp
    10d5:	83 ec 08             	sub    $0x8,%esp
    10d8:	6a 04                	push   $0x4
    10da:	8d 83 00 04 00 00    	lea    0x400(%ebx),%eax
    10e0:	50                   	push   %eax
    10e1:	e8 b5 fe ff ff       	call   f9b <__gmon_start__@plt+0x8d3>
    10e6:	83 c4 10             	add    $0x10,%esp
    10e9:	83 ec 08             	sub    $0x8,%esp
    10ec:	6a 03                	push   $0x3
    10ee:	8d 83 60 03 00 00    	lea    0x360(%ebx),%eax
    10f4:	50                   	push   %eax
    10f5:	e8 a1 fe ff ff       	call   f9b <__gmon_start__@plt+0x8d3>
    10fa:	83 c4 10             	add    $0x10,%esp
    10fd:	e8 de f4 ff ff       	call   5e0 <getchar@plt>
    1102:	e8 d9 f4 ff ff       	call   5e0 <getchar@plt>
    1107:	90                   	nop
    1108:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    110b:	c9                   	leave  
    110c:	c3                   	ret    
    110d:	55                   	push   %ebp
    110e:	89 e5                	mov    %esp,%ebp
    1110:	53                   	push   %ebx
    1111:	83 ec 04             	sub    $0x4,%esp
    1114:	e8 f7 f5 ff ff       	call   710 <__gmon_start__@plt+0x48>
    1119:	81 c3 87 1e 00 00    	add    $0x1e87,%ebx
    111f:	83 ec 0c             	sub    $0xc,%esp
    1122:	8d 83 60 e3 ff ff    	lea    -0x1ca0(%ebx),%eax
    1128:	50                   	push   %eax
    1129:	e8 22 f5 ff ff       	call   650 <system@plt>
    112e:	83 c4 10             	add    $0x10,%esp
    1131:	83 ec 08             	sub    $0x8,%esp
    1134:	6a 03                	push   $0x3
    1136:	8d 83 60 04 00 00    	lea    0x460(%ebx),%eax
    113c:	50                   	push   %eax
    113d:	e8 59 fe ff ff       	call   f9b <__gmon_start__@plt+0x8d3>
    1142:	83 c4 10             	add    $0x10,%esp
    1145:	83 ec 08             	sub    $0x8,%esp
    1148:	6a 03                	push   $0x3
    114a:	8d 83 60 03 00 00    	lea    0x360(%ebx),%eax
    1150:	50                   	push   %eax
    1151:	e8 45 fe ff ff       	call   f9b <__gmon_start__@plt+0x8d3>
    1156:	83 c4 10             	add    $0x10,%esp
    1159:	e8 82 f4 ff ff       	call   5e0 <getchar@plt>
    115e:	e8 7d f4 ff ff       	call   5e0 <getchar@plt>
    1163:	90                   	nop
    1164:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1167:	c9                   	leave  
    1168:	c3                   	ret    
    1169:	55                   	push   %ebp
    116a:	89 e5                	mov    %esp,%ebp
    116c:	53                   	push   %ebx
    116d:	83 ec 04             	sub    $0x4,%esp
    1170:	e8 9b f5 ff ff       	call   710 <__gmon_start__@plt+0x48>
    1175:	81 c3 2b 1e 00 00    	add    $0x1e2b,%ebx
    117b:	83 ec 0c             	sub    $0xc,%esp
    117e:	8d 83 60 e3 ff ff    	lea    -0x1ca0(%ebx),%eax
    1184:	50                   	push   %eax
    1185:	e8 c6 f4 ff ff       	call   650 <system@plt>
    118a:	83 c4 10             	add    $0x10,%esp
    118d:	83 ec 08             	sub    $0x8,%esp
    1190:	6a 03                	push   $0x3
    1192:	8d 83 c0 04 00 00    	lea    0x4c0(%ebx),%eax
    1198:	50                   	push   %eax
    1199:	e8 fd fd ff ff       	call   f9b <__gmon_start__@plt+0x8d3>
    119e:	83 c4 10             	add    $0x10,%esp
    11a1:	83 ec 08             	sub    $0x8,%esp
    11a4:	6a 03                	push   $0x3
    11a6:	8d 83 60 03 00 00    	lea    0x360(%ebx),%eax
    11ac:	50                   	push   %eax
    11ad:	e8 e9 fd ff ff       	call   f9b <__gmon_start__@plt+0x8d3>
    11b2:	83 c4 10             	add    $0x10,%esp
    11b5:	e8 26 f4 ff ff       	call   5e0 <getchar@plt>
    11ba:	e8 21 f4 ff ff       	call   5e0 <getchar@plt>
    11bf:	90                   	nop
    11c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11c3:	c9                   	leave  
    11c4:	c3                   	ret    
    11c5:	55                   	push   %ebp
    11c6:	89 e5                	mov    %esp,%ebp
    11c8:	53                   	push   %ebx
    11c9:	83 ec 04             	sub    $0x4,%esp
    11cc:	e8 3f f5 ff ff       	call   710 <__gmon_start__@plt+0x48>
    11d1:	81 c3 cf 1d 00 00    	add    $0x1dcf,%ebx
    11d7:	83 ec 0c             	sub    $0xc,%esp
    11da:	8d 83 60 e3 ff ff    	lea    -0x1ca0(%ebx),%eax
    11e0:	50                   	push   %eax
    11e1:	e8 6a f4 ff ff       	call   650 <system@plt>
    11e6:	83 c4 10             	add    $0x10,%esp
    11e9:	83 ec 08             	sub    $0x8,%esp
    11ec:	6a 03                	push   $0x3
    11ee:	8d 83 20 05 00 00    	lea    0x520(%ebx),%eax
    11f4:	50                   	push   %eax
    11f5:	e8 a1 fd ff ff       	call   f9b <__gmon_start__@plt+0x8d3>
    11fa:	83 c4 10             	add    $0x10,%esp
    11fd:	83 ec 08             	sub    $0x8,%esp
    1200:	6a 03                	push   $0x3
    1202:	8d 83 60 03 00 00    	lea    0x360(%ebx),%eax
    1208:	50                   	push   %eax
    1209:	e8 8d fd ff ff       	call   f9b <__gmon_start__@plt+0x8d3>
    120e:	83 c4 10             	add    $0x10,%esp
    1211:	e8 ca f3 ff ff       	call   5e0 <getchar@plt>
    1216:	e8 c5 f3 ff ff       	call   5e0 <getchar@plt>
    121b:	90                   	nop
    121c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    121f:	c9                   	leave  
    1220:	c3                   	ret    
    1221:	8b 04 24             	mov    (%esp),%eax
    1224:	c3                   	ret    
    1225:	66 90                	xchg   %ax,%ax
    1227:	66 90                	xchg   %ax,%ax
    1229:	66 90                	xchg   %ax,%ax
    122b:	66 90                	xchg   %ax,%ax
    122d:	66 90                	xchg   %ax,%ax
    122f:	90                   	nop
    1230:	55                   	push   %ebp
    1231:	57                   	push   %edi
    1232:	56                   	push   %esi
    1233:	53                   	push   %ebx
    1234:	e8 d7 f4 ff ff       	call   710 <__gmon_start__@plt+0x48>
    1239:	81 c3 67 1d 00 00    	add    $0x1d67,%ebx
    123f:	83 ec 0c             	sub    $0xc,%esp
    1242:	8b 6c 24 28          	mov    0x28(%esp),%ebp
    1246:	8d b3 04 ff ff ff    	lea    -0xfc(%ebx),%esi
    124c:	e8 33 f3 ff ff       	call   584 <strstr@plt-0x3c>
    1251:	8d 83 00 ff ff ff    	lea    -0x100(%ebx),%eax
    1257:	29 c6                	sub    %eax,%esi
    1259:	c1 fe 02             	sar    $0x2,%esi
    125c:	85 f6                	test   %esi,%esi
    125e:	74 25                	je     1285 <__gmon_start__@plt+0xbbd>
    1260:	31 ff                	xor    %edi,%edi
    1262:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1268:	83 ec 04             	sub    $0x4,%esp
    126b:	55                   	push   %ebp
    126c:	ff 74 24 2c          	pushl  0x2c(%esp)
    1270:	ff 74 24 2c          	pushl  0x2c(%esp)
    1274:	ff 94 bb 00 ff ff ff 	call   *-0x100(%ebx,%edi,4)
    127b:	83 c7 01             	add    $0x1,%edi
    127e:	83 c4 10             	add    $0x10,%esp
    1281:	39 fe                	cmp    %edi,%esi
    1283:	75 e3                	jne    1268 <__gmon_start__@plt+0xba0>
    1285:	83 c4 0c             	add    $0xc,%esp
    1288:	5b                   	pop    %ebx
    1289:	5e                   	pop    %esi
    128a:	5f                   	pop    %edi
    128b:	5d                   	pop    %ebp
    128c:	c3                   	ret    
    128d:	8d 76 00             	lea    0x0(%esi),%esi
    1290:	f3 c3                	repz ret 
    1292:	66 90                	xchg   %ax,%ax
    1294:	66 90                	xchg   %ax,%ax
    1296:	66 90                	xchg   %ax,%ax
    1298:	66 90                	xchg   %ax,%ax
    129a:	66 90                	xchg   %ax,%ax
    129c:	66 90                	xchg   %ax,%ax
    129e:	66 90                	xchg   %ax,%ax
    12a0:	53                   	push   %ebx
    12a1:	e8 6a f4 ff ff       	call   710 <__gmon_start__@plt+0x48>
    12a6:	81 c3 fa 1c 00 00    	add    $0x1cfa,%ebx
    12ac:	83 ec 0c             	sub    $0xc,%esp
    12af:	ff 74 24 18          	pushl  0x18(%esp)
    12b3:	ff 74 24 18          	pushl  0x18(%esp)
    12b7:	6a 03                	push   $0x3
    12b9:	e8 62 f3 ff ff       	call   620 <__xstat@plt>
    12be:	83 c4 18             	add    $0x18,%esp
    12c1:	5b                   	pop    %ebx
    12c2:	c3                   	ret    
    12c3:	66 90                	xchg   %ax,%ax
    12c5:	66 90                	xchg   %ax,%ax
    12c7:	66 90                	xchg   %ax,%ax
    12c9:	66 90                	xchg   %ax,%ax
    12cb:	66 90                	xchg   %ax,%ax
    12cd:	66 90                	xchg   %ax,%ax
    12cf:	90                   	nop
    12d0:	53                   	push   %ebx
    12d1:	e8 3a f4 ff ff       	call   710 <__gmon_start__@plt+0x48>
    12d6:	81 c3 ca 1c 00 00    	add    $0x1cca,%ebx
    12dc:	83 ec 08             	sub    $0x8,%esp
    12df:	e8 2c f3 ff ff       	call   610 <__stack_chk_fail@plt>

Disassembly of section .fini:

000012e4 <.fini>:
    12e4:	53                   	push   %ebx
    12e5:	83 ec 08             	sub    $0x8,%esp
    12e8:	e8 23 f4 ff ff       	call   710 <__gmon_start__@plt+0x48>
    12ed:	81 c3 b3 1c 00 00    	add    $0x1cb3,%ebx
    12f3:	83 c4 08             	add    $0x8,%esp
    12f6:	5b                   	pop    %ebx
    12f7:	c3                   	ret    
