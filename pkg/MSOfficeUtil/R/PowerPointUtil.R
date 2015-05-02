.powerpoint = "PowerPoint.Application"


exportGraphToPowerPoint = function (object, file.name, overwrite = TRUE, ...) 
{
    if (class(object) == "trellis") 
        object = list(object)
    fn = gsub("/", "\\\\", file.name)
    if ( !file.exists(dirname(fn)) )
        stop("No such directory.")
        
    .COMInit()
    ppt = COMCreate("PowerPoint.Application")
    ppt[["Visible"]] = TRUE
    present = ppt[["presentations"]]
    if (file.exists(fn) & !overwrite) 
        present$Open(fn)
    else
    {
        if (file.exists(fn)) 
            file.remove(fn)
        present$Add()
        present$Item(1)$SaveAs(fn)
    }
    slides = present$Item(1)[["slides"]]
    theme = trellis.par.get()
    n.dev = dev.cur()
    n = slides[["Count"]]
    for (i in 1:length(object))
    {
        slides$Add(n + i, 12)
        exportSingleGraphToPowerPoint(object[[i]], slides, theme, ...)
    }
    n = slides[["Count"]]
    present$Item(1)$Save()
    present$Item(1)$Close()
    ppt$Quit()
    ppt = present = slides = NULL
    rm(ppt, present, slides)
    gc()
    .COMInit(FALSE)
    while (dev.cur() > n.dev) dev.off()
    invisible()
}

exportSingleGraphToPowerPoint = function (p, slides, theme, ...) 
{
    n = slides[["Count"]]
    file.out = paste(getwd(), tempfile(), n, ".emf", sep = "")
    trellis.device(device = "win.metafile", file = file.out, ...)
    lset(theme)
    print(p)
    dev.off()
    file.out = gsub("/", "\\\\", file.out)
    slides$Item(n)[["Shapes"]]$AddPicture(file.out, LinkToFile = FALSE, 
        SaveWithDocument = TRUE, Left = 85, Top = 65, Width = 560, 
        Height = 420)
    file.remove(file.out)
    invisible()
}
