<?php

declare(strict_types=1);

namespace App\Actions;

use Illuminate\Support\Facades\Process;
use Lorisleiva\Actions\Concerns\AsAction;

class InstallGit
{
    use AsAction;

    public function handle(): void
    {
        $installedVersion = $this->getInstalledVersion();

        if ($installedVersion) {
            return;
        }

        $this->installGit();
    }

    protected function getInstalledVersion(): string
    {
        return Process::run('git --version')
            ->output();
    }

    protected function installGit(): void
    {
        Process::run("xcode-select --install");
    }
}
