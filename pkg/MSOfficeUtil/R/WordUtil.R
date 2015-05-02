.word = "Word.Application"
exportGraphToWord = function(object, file.name, overwrite=TRUE)
{

    if ( class(object)=="trellis" )
        object = list(object)

    fn = gsub("/", "\\\\", file.name)
    if ( !file.exists(dirname(fn)) )
        stop("No such directory.")

    .COMInit()
    word = COMCreate("Word.Application")
    word[["Visible"]] = TRUE
    o = word[["Options"]]
    o[["SavePropertiesPrompt"]] = FALSE
    doc=word[["Documents"]]

    if ( file.exists(fn) & !overwrite )
    {
        doc$Open(fn)    ## Open a particular word document
        doc$Item(1)[["Content"]]$InsertBreak(Type=2)
    }
    else    ## Create new powerpoint document
    {
        if ( file.exists(fn) )
            file.remove(fn)
        doc$Add()
        doc$Item(1)$SaveAs(fn)

    }

    theme = trellis.par.get()
    n.dev = dev.cur()

    for ( i in 1:length(object) )
    {
      exportSingleGraphToWord( object[[i]], theme=theme)
    }

    doc$Item(1)$Save()
    doc$Item(1)$Close()

    o[["SavePropertiesPrompt"]] = TRUE

    word$Quit()

    word = doc = NULL
    rm(word, doc)
    gc()
    .COMInit(FALSE)

    invisible()

}

exportSingleGraphToWord = function (p, theme, ...) 
{

  # export the plot to a temp file
  file.out <- paste( tempfile("plot", ".emf", sep="") )
  trellis.device(device = "win.metafile", file=file.out)
  lset(theme)
  print(p)
  dev.off()

  # insert into Word doc
  doc$Item(1)[["Shapes"]]$AddPicture(FileName=file.out,
                                     LinkToFile=FALSE,
                                     saveWithDocument=TRUE)
  if ( i > 1 )
    doc$Item(1)[["Content"]]$InsertBreak(Type=2)

  # remove the temp file
  file.remove( file.out )

  invisible()
}
