
unsigned __stdcall visible_watch(void *ArgList)
{
    HANDLE hEvent = *((HANDLE *)ArgList);

    while (WaitForSingleObject(hEvent, 0) != WAIT_OBJECT_0) {
        Sleep(5000);
    }
    return 0;
}

{
    unsigned ThreadId;
    HANDLE hThread, hEvent;
    hEvent = CreateEvent(NULL, TRUE, FALSE, NULL);
    hThread = (HANDLE)_beginthreadex(NULL, 0, visible_watch, &hEvent, 0, &ThreadId);
    if (hThread == INVALID_HANDLE_VALUE) {
        /// no way...exit
    }
    SetEvent(hEvent);
    int rv = WaitForSingleObject(hThread, INFINITE);

    CloseHandle(hEvent);
    CloseHandle(hThread);
}
